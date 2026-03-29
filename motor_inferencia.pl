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

% Si el archivo no existe (usuario nuevo), devolverá una lista vacía de materias aprobadas.
cargar_expediente(Archivo, []) :-
    \+ exists_file(Archivo). 

% ========================================================
% BLOQUE 2: VALIDACIÓN DE MATRÍCULA
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
% BLOQUE 3: RUTAS CRÍTICAS (RECURSIVIDAD Y ÁRBOLES)
% ========================================================

% 3.1 Ruta Hacia Atrás: ¿Qué materias me bloquean llegar hasta aquí?
% Caso base: Si el código es 'ninguno' o vacío, la ruta termina aquí (lista vacía).
ruta_critica_atras(_, ninguno, []) :- !.

% Caso recursivo: Si hay materia, busca recursivamente los requisitos de sus requisitos.
ruta_critica_atras(Carrera, Codigo, [Codigo | Dependencias_Restantes]) :-
    materia(Carrera, Codigo, _, _, _, _, Prerreq, Preced),
    ruta_critica_atras(Carrera, Prerreq, RutaPrerreq),
    ruta_critica_atras(Carrera, Preced, RutaPreced),
    % Unimos las dos sub-ramas encontradas (prerrequisitos y precedentes) en una sola lista plana
    append(RutaPrerreq, RutaPreced, Dependencias_Restantes).

% 3.2 Ruta Hacia Adelante: ¿Qué materias futuras se desbloquean si apruebo esta?
% Busca a todas las materias que tengan a nuestro 'Codigo' como Prerrequisito O Precedente
desbloqueos_inmediatos(Carrera, Codigo, MateriasDesbloqueadas) :-
    findall(Futura, 
           (materia(Carrera, Futura, _, _, _, _, Codigo, _); 
            materia(Carrera, Futura, _, _, _, _, _, Codigo)), 
           MateriasDesbloqueadas).

% NOTA: La recursividad profunda hacia adelante requiere recorrer listas. Dejaremos esta 
% función como "Inmediata" para no saturar los resultados, pero sentando las bases.
