:- ensure_loaded('plan_ice_2026.pl'). % Importar la base de conocimientos

% ========================================================
% BLOQUE 1: MANEJO DE EXPEDIENTE ESTUDIANTIL (I/O)
% ========================================================

% guardar_expediente(+ListaMaterias, +NombreArchivo)
% Permite guardar localmente las notas/expedientes de un usuario.
guardar_expediente(Expediente, Archivo) :-
    open(Archivo, write, Stream),
    write(Stream, Expediente),
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

% habilitado_para_matricular(+Carrera, +CodigoMateria, +ExpedienteActual)
% Decide si un alumno puede cursar 'X' materia.
habilitado_para_matricular(Carrera, Codigo, Expediente) :-
    materia(Carrera, Codigo, _, _, _, _, Prerreq, Preced),
    \+ member(Codigo, Expediente), 
    cumple_requisito(Prerreq, Expediente),
    cumple_requisito(Preced, Expediente).

% ========================================================
% BLOQUE 3: RUTAS CRITICAS (RECURSIVIDAD Y ARBOLES)
% ========================================================

% 3.1 Ruta Hacia Atras: ¿Que materias me bloquean llegar hasta aqui?
% Caso base: Si el codigo es 'ninguno' o vacio, la ruta termina aqui (lista vacia).
ruta_critica_atras(_, ninguno, []) :- !.

% Caso recursivo: Si hay materia, busca recursivamente los requisitos de sus requisitos.
ruta_critica_atras(Carrera, Codigo, [Codigo | Dependencias_Restantes]) :-
    materia(Carrera, Codigo, _, _, _, _, Prerreq, Preced),
    ruta_critica_atras(Carrera, Prerreq, RutaPrerreq),
    ruta_critica_atras(Carrera, Preced, RutaPreced),
    % Unimos las dos sub-ramas encontradas (prerrequisitos y precedentes) en una sola lista plana
    append(RutaPrerreq, RutaPreced, Dependencias_Restantes).

% 3.2 Ruta Hacia Adelante: ¿Que materias futuras se desbloquean si apruebo esta?
% Busca a todas las materias que tengan a nuestro 'Codigo' como Prerrequisito O Precedente
desbloqueos_inmediatos(Carrera, Codigo, MateriasDesbloqueadas) :-
    findall(Futura, 
           (materia(Carrera, Futura, _, _, _, _, Codigo, _); 
            materia(Carrera, Futura, _, _, _, _, _, Codigo)), 
           MateriasDesbloqueadas).

% NOTA: La recursividad profunda hacia adelante requiere recorrer listas. Dejaremos esta 
% funcion como "Inmediata" para no saturar los resultados, pero sentando las bases.

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

% ========================================================
% BLOQUE 5: RECOMENDADOR INTELIGENTE (CUELLOS DE BOTELLA)
% ========================================================

% peso_bloqueo(+Carrera, +CodigoMateria, -CantidadBloqueadas)
% Calcula a cuantas materias "arrastra" o afecta directamente esta clase si no se aprueba rapido.
peso_bloqueo(Carrera, Codigo, Peso) :-
    desbloqueos_inmediatos(Carrera, Codigo, ListaAfectadas),
    length(ListaAfectadas, Peso).

% recomendar_recuperacion(+Carrera, +MateriaReprobada, -Prioridad)
% Inteligencia artificial basica: Etiqueta como 'Prioridad Alta' si bloquea a 2 o mas materias a futuro.
recomendar_recuperacion(Carrera, Codigo, 'Prioridad Alta (Cuello de Botella!)') :-
    peso_bloqueo(Carrera, Codigo, Peso),
    Peso >= 2, !.

recomendar_recuperacion(_, _, 'Prioridad Normal'). % Si bloquea a 1 o 0 materias, es normal.
