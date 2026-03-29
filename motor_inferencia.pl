:- ensure_loaded('plan_ice_2026.pl'). % Importar la base de conocimientos

% ========================================================
% BLOQUE 1: MANEJO DE EXPEDIENTE ESTUDIANTIL (I/O)
% ========================================================

% guardar_expediente(+ListaMaterias, +NombreArchivo)
% Permite guardar localmente las notas/expedientes de un usuario.
% Ejemplo: guardar_expediente(['0101', '0901', '0403'], 'expediente_fer.txt').
guardar_expediente(Expediente, Archivo) :-
    open(Archivo, write, Stream),
    write(Stream, Expediente),
    write(Stream, '.'), % En Prolog, todo término debe terminar con un punto para poder ser leído después.
    close(Stream).

% cargar_expediente(+NombreArchivo, -ListaMaterias)
% Lee el historial de un usuario devolviendo una lista.
cargar_expediente(Archivo, Expediente) :-
    exists_file(Archivo),
    open(Archivo, read, Stream),
    read(Stream, Expediente), % Lee la lista directamente desde el archivo de texto
    close(Stream).

% Si el archivo no existe (usuario nuevo), devolverá una lista vacía de materias aprobadas.
cargar_expediente(Archivo, []) :-
    \+ exists_file(Archivo). 

% ========================================================
% BLOQUE 2: VALIDACIÓN DE MATRÍCULA
% ========================================================

% cumple_requisito(+Requisito, +Expediente)
% Verifica si el prerequisito exigido ya se encuentra en el perfil del estudiante.
cumple_requisito(ninguno, _). % Si la materia base dice 'ninguno', pasa automáticamente.

cumple_requisito(Requisito, Expediente) :-
    Requisito \== ninguno,
    member(Requisito, Expediente). % Revisa si el código está dentro de la lista de materias aprobadas.

% habilitado_para_matricular(+Carrera, +CodigoMateria, +ExpedienteActual)
% El corazón del Simulador de Matrícula: decide si un alumno puede cursar 'X' materia.
habilitado_para_matricular(Carrera, Codigo, Expediente) :-
    % 1. Extraemos qué nos pide la materia desde la base de datos (ignora otros datos inútiles con guion bajo _)
    materia(Carrera, Codigo, _, _, _, _, Prerreq, Preced),
    
    % 2. La regla matemática falla si tú YA aprobasete la clase (no la puedes repetir).
    \+ member(Codigo, Expediente), 
    
    % 3. Comparamos que cumplas ambos requisitos.
    cumple_requisito(Prerreq, Expediente),
    cumple_requisito(Preced, Expediente).
