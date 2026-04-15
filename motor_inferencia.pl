:- ensure_loaded('planes/plan_ice_2026.pl'). % Importar la base de conocimientos ICE
:- ensure_loaded('planes/plan_igi_2026.pl'). % Importar la base de conocimientos IGI
:- ensure_loaded('planes/plan_ime_2026.pl'). % Importar la base de conocimientos IME
:- ensure_loaded('planes/plan_ims_2026.pl'). % Importar la base de conocimientos IMS
:- ensure_loaded('planes/plan_iem_2026.pl'). % Importar la base de conocimientos IEM
:- ensure_loaded('planes/plan_laf_2026.pl'). % Importar la base de conocimientos LAF
:- ensure_loaded('planes/plan_lcm_2026.pl'). % Importar la base de conocimientos LCM
:- ensure_loaded('planes/plan_iel_2026.pl'). % Importar la base de conocimientos IEL
:- use_module(library(lists)).

% ========================================================
% BLOQUE 1: MANEJO DE EXPEDIENTE ESTUDIANTIL (I/O)
% ========================================================

% guardar_expediente(+ListaMaterias, +NombreArchivo)
% Permite guardar localmente las notas/expedientes de un usuario.
guardar_expediente(Expediente, Archivo) :-
    open(Archivo, write, Stream),
    writeq(Stream, Expediente),
    write(Stream, '.'),
    close(Stream).

% cargar_expediente(+NombreArchivo, -ListaMaterias)
% Lee el historial de un usuario devolviendo una lista.
cargar_expediente(Archivo, Expediente) :-
    exists_file(Archivo),
    open(Archivo, read, Stream),
    read(Stream, Expediente),
    close(Stream).

% Si el archivo no existe (usuario nuevo), devolvera una lista vacia de materias aprobadas.
cargar_expediente(Archivo, []) :-
    \+ exists_file(Archivo). 

% ========================================================
% BLOQUE 2: VALIDACION DE MATRICULA
% ========================================================

% cumple_requisito(+Requisito, +Expediente)
cumple_requisito(ninguno, _).

cumple_requisito(Requisito, Expediente) :-
    Requisito \== ninguno,
    member(Requisito, Expediente).

% requisitos_pendientes(+Carrera, +CodigoMateria, +Expediente, -Faltantes)
% Devuelve los requisitos (prerrequisito/precedente) que faltan por aprobar.
requisitos_pendientes(Carrera, Codigo, Expediente, Faltantes) :-
    materia(Carrera, Codigo, _, _, _, _, Prerreq, Preced),
    findall(Req,
        (
            member(Req, [Prerreq, Preced]),
            Req \== ninguno,
            \+ member(Req, Expediente)
        ),
        Lista),
    sort(Lista, Faltantes).

% habilitado_para_matricular(+Carrera, +CodigoMateria, +ExpedienteActual)
% Decide si un alumno puede cursar 'X' materia.
habilitado_para_matricular(Carrera, Codigo, Expediente) :-
    materia(Carrera, Codigo, _, _, _, _, _, _),
    \+ member(Codigo, Expediente),
    requisitos_pendientes(Carrera, Codigo, Expediente, []).

% materias_habilitadas(+Carrera, +Expediente, -Codigos)
% Lista de materias legalmente disponibles para matricular.
materias_habilitadas(Carrera, Expediente, Codigos) :-
    findall(Codigo, habilitado_para_matricular(Carrera, Codigo, Expediente), Lista),
    sort(Lista, Codigos).

% materias_bloqueadas(+Carrera, +Expediente, -ParesMateriaFaltantes)
% Lista de pares Codigo-Faltantes para materias aun no habilitadas.
materias_bloqueadas(Carrera, Expediente, Bloqueadas) :-
    findall(Codigo-Faltantes,
        (
            materia(Carrera, Codigo, _, _, _, _, _, _),
            \+ member(Codigo, Expediente),
            requisitos_pendientes(Carrera, Codigo, Expediente, Faltantes),
            Faltantes \= []
        ),
        Bloqueadas).

% ========================================================
% BLOQUE 3: RUTAS CRITICAS (RECURSIVIDAD Y ARBOLES)
% ========================================================

% 3.1 Ruta Hacia Atras: ¿Que materias me bloquean llegar hasta aqui?
% Caso base: Si el codigo es 'ninguno', la ruta termina aqui (lista vacia).
ruta_critica_atras(_, ninguno, []) :- !.

% API publica: elimina repetidos manteniendo orden.
ruta_critica_atras(Carrera, Codigo, RutaUnica) :-
    ruta_critica_atras_aux(Carrera, Codigo, Ruta),
    eliminar_duplicados_preservando_orden(Ruta, RutaUnica).

ruta_critica_atras_aux(_, ninguno, []) :- !.
ruta_critica_atras_aux(Carrera, Codigo, [Codigo | Dependencias_Restantes]) :-
    materia(Carrera, Codigo, _, _, _, _, Prerreq, Preced),
    ruta_critica_atras_aux(Carrera, Prerreq, RutaPrerreq),
    ruta_critica_atras_aux(Carrera, Preced, RutaPreced),
    % Unimos las dos sub-ramas encontradas (prerrequisitos y precedentes) en una sola lista plana
    append(RutaPrerreq, RutaPreced, Dependencias_Restantes).

% 3.2 Ruta Hacia Adelante: ¿Que materias futuras se desbloquean si apruebo esta?
% Busca a todas las materias que tengan a nuestro 'Codigo' como Prerrequisito o Precedente
desbloqueos_inmediatos(Carrera, Codigo, MateriasDesbloqueadas) :-
    findall(Futura,
           (materia(Carrera, Futura, _, _, _, _, Codigo, _);
            materia(Carrera, Futura, _, _, _, _, _, Codigo)),
           Lista),
    sort(Lista, MateriasDesbloqueadas).

% ruta_critica_adelante(+Carrera, +CodigoMateria, -Ruta)
% Ruta recursiva de desbloqueos directos e indirectos.
ruta_critica_adelante(Carrera, Codigo, Ruta) :-
    ruta_critica_adelante_aux(Carrera, [Codigo], [], Ruta).

ruta_critica_adelante_aux(_, [], Visitados, Ruta) :-
    subtract(Visitados, [], Ruta).
ruta_critica_adelante_aux(Carrera, [Actual | Pendientes], Visitados, Ruta) :-
    desbloqueos_inmediatos(Carrera, Actual, Inmediatos),
    subtract(Inmediatos, Visitados, Nuevos),
    append(Pendientes, Nuevos, Cola),
    append(Visitados, Nuevos, Visitados2),
    ruta_critica_adelante_aux(Carrera, Cola, Visitados2, Ruta).

% ========================================================
% BLOQUE 4: CALCULADORA DE CREDITOS Y PROGRESO
% ========================================================

% calcular_creditos(+Carrera, +ListaMateriasAprobadas, -TotalCreditos)
% Itera sobre la lista de materias aprobadas y suma sus creditos.
calcular_creditos(_, [], 0). % Caso base: Lista vacia significa 0 creditos.

calcular_creditos(Carrera, [Codigo | Restantes], Total) :-
    materia(Carrera, Codigo, _, _, _, CreditosMateria, _, _),
    calcular_creditos(Carrera, Restantes, TotalRestantes),
    Total is CreditosMateria + TotalRestantes. % Sumatoria recursiva

% total_creditos_carrera(+Carrera, -Total)
total_creditos_carrera(Carrera, Total) :-
    findall(C, materia(Carrera, _, _, _, _, C, _, _), ListaCreditos),
    sum_list(ListaCreditos, Total).

% progreso_creditos(+Carrera, +Expediente, -Aprobados, -Restantes, -TotalCarrera)
progreso_creditos(Carrera, Expediente, Aprobados, Restantes, TotalCarrera) :-
    calcular_creditos(Carrera, Expediente, Aprobados),
    total_creditos_carrera(Carrera, TotalCarrera),
    Restantes is TotalCarrera - Aprobados.

% ========================================================
% BLOQUE 5: RECOMENDADOR INTELIGENTE (CUELLOS DE BOTELLA)
% ========================================================

% peso_bloqueo(+Carrera, +CodigoMateria, -CantidadBloqueadas)
% Calcula a cuantas materias arrastra (directa e indirectamente) esta clase.
peso_bloqueo(Carrera, Codigo, Peso) :-
    ruta_critica_adelante(Carrera, Codigo, ListaAfectadas),
    length(ListaAfectadas, Peso).

% recomendar_recuperacion(+Carrera, +MateriaReprobada, -Prioridad)
% Inteligencia artificial basica: Etiqueta como 'Prioridad Alta' si bloquea a 2 o mas materias a futuro.
recomendar_recuperacion(Carrera, Codigo, 'Prioridad Alta (Cuello de Botella!)') :-
    peso_bloqueo(Carrera, Codigo, Peso),
    Peso >= 2, !.

recomendar_recuperacion(_, _, 'Prioridad Normal'). % Si bloquea a 1 o 0 materias, es normal.

% materias_adelantables(+Carrera, +Expediente, +Reprobadas, -Sugeridas)
% Sugerencias para adelantar sin tocar materias reprobadas.
materias_adelantables(Carrera, Expediente, Reprobadas, Sugeridas) :-
    materias_habilitadas(Carrera, Expediente, Habilitadas),
    subtract(Habilitadas, Reprobadas, Sugeridas).

% eliminar_duplicados_preservando_orden(+Lista, -SinDuplicados)
eliminar_duplicados_preservando_orden(Lista, SinDuplicados) :-
    eliminar_duplicados_preservando_orden(Lista, [], SinDuplicados).

eliminar_duplicados_preservando_orden([], _, []).
eliminar_duplicados_preservando_orden([X | Resto], Vistos, Salida) :-
    member(X, Vistos), !,
    eliminar_duplicados_preservando_orden(Resto, Vistos, Salida).
eliminar_duplicados_preservando_orden([X | Resto], Vistos, [X | Salida]) :-
    eliminar_duplicados_preservando_orden(Resto, [X | Vistos], Salida).
