% Base de Conocimientos: Plan de Estudios ICE 2026
% Formato: materia(Carrera, Codigo, Nombre, Ano, Cuatrimestre, Creditos, Prerrequisito, Precedente).
% Utilizamos 'ninguno' cuando no existe dependencia.

:- discontiguous materia/8.
:- multifile materia/8.

% --- ANO I ---
% Cuatrimestre I
materia(ice, '0401', 'Etica y Lasallismo', 1, 1, 2, ninguno, ninguno).
materia(ice, '0901', 'Introduccion a la Ingenieria', 1, 1, 4, ninguno, ninguno).
materia(ice, '0101', 'Matematica I', 1, 1, 3, ninguno, ninguno).
materia(ice, '0701', 'Ofimatica Aplicada', 1, 1, 3, ninguno, ninguno).
materia(ice, '0402', 'Identidad Nacional y Orgullo Patrio', 1, 1, 4, ninguno, ninguno).

% Cuatrimestre II
materia(ice, '0902', 'Dibujo Tecnico Asistido', 1, 2, 3, ninguno, '0901').
materia(ice, '0403', 'Ingles I', 1, 2, 2, ninguno, ninguno).
materia(ice, '0102', 'Matematica II', 1, 2, 3, '0101', ninguno).
materia(ice, '0201', 'Fisica', 1, 2, 4, ninguno, '0101').
materia(ice, '0404', 'Redaccion Tecnica', 1, 2, 3, ninguno, ninguno).

% Cuatrimestre III
materia(ice, '0405', 'Ingles II', 1, 3, 2, ninguno, '0403').
materia(ice, '0702', 'Introduccion a la Programacion', 1, 3, 3, ninguno, ninguno).
materia(ice, '0103', 'Matematica III', 1, 3, 3, '0102', ninguno).
materia(ice, '0203', 'Quimica General', 1, 3, 3, ninguno, ninguno).
materia(ice, '0406', 'Historia e Identidad Nacional', 1, 3, 3, ninguno, ninguno).

% --- ANO II ---
% Cuatrimestre IV
materia(ice, '0301', 'Circuitos Electricos', 2, 4, 4, ninguno, '0103').
materia(ice, '0104', 'Matematica IV', 2, 4, 3, '0103', ninguno).
materia(ice, '0703', 'Lenguaje de Programacion I', 2, 4, 3, ninguno, '0702').
materia(ice, '0105', 'Probabilidad y Estadistica', 2, 4, 3, ninguno, '0103').
materia(ice, '0204', 'Estatica', 2, 4, 3, ninguno, '0201').

% Cuatrimestre V
materia(ice, '0106', 'Analisis Numerico', 2, 5, 3, ninguno, '0703').
materia(ice, '0205', 'Dinamica', 2, 5, 3, '0204', ninguno).
materia(ice, '0107', 'Investigacion de Operaciones I', 2, 5, 3, ninguno, '0105').
materia(ice, '0705', 'Lenguaje de Programacion II', 2, 5, 3, '0703', ninguno).
materia(ice, '0407', 'Ingles III', 2, 5, 2, ninguno, '0405').

% Cuatrimestre VI
materia(ice, '0501', 'Electronica Analogica', 2, 6, 4, '0301', ninguno).
materia(ice, '0706', 'Sistemas Operativos I', 2, 6, 3, ninguno, '0705').
materia(ice, '0707', 'Base de datos y Programacion Orientada a Objetos', 2, 6, 3, '0705', ninguno).
materia(ice, '0408', 'Iglesia, Laicado y Ecumenismo', 2, 6, 2, ninguno, '0401').
materia(ice, '0708', 'Estructura de Datos y Organizacion de Archivos', 2, 6, 4, ninguno, '0705').

% --- ANO III ---
% Cuatrimestre VII
materia(ice, '0502', 'Electronica Digital I', 3, 7, 3, ninguno, '0501').
materia(ice, '0503', 'Mando Electromecanico', 3, 7, 3, '0301', ninguno).
materia(ice, '0209', 'Ingenieria Ambiental I', 3, 7, 2, ninguno, '0203').
materia(ice, '0504', 'Electronica Industrial', 3, 7, 4, ninguno, '0501').
materia(ice, '0709', 'Sistemas Operativos II', 3, 7, 3, '0706', ninguno).

% Cuatrimestre VIII
materia(ice, '0505', 'Instrumentacion y Control', 3, 8, 3, '0504', ninguno).
materia(ice, '0601', 'Metodologia de la Investigacion', 3, 8, 2, '0404', ninguno).
materia(ice, '1001', 'Teoria Computacional', 3, 8, 2, ninguno, '0708').
materia(ice, '0710', 'Arquitectura de Computadoras', 3, 8, 3, ninguno, '0706').
materia(ice, '0711', 'Diseno Web', 3, 8, 3, ninguno, '0707').

% Cuatrimestre IX
materia(ice, '0712', 'Tecnologia de Redes', 3, 9, 3, '0710', ninguno).
materia(ice, '0507', 'Sistemas de Control', 3, 9, 3, '0505', ninguno).
materia(ice, '0508', 'Control Logico Programable', 3, 9, 3, ninguno, '0503').
materia(ice, '0109', 'Modelos de Simulacion', 3, 9, 3, '0107', ninguno).
materia(ice, '0802', 'Principios de Administracion', 3, 9, 3, ninguno, ninguno).

% --- ANO IV ---
% Cuatrimestre X
materia(ice, '0713', 'Medios y Protocolos de Comunicacion', 4, 10, 3, '0712', ninguno).
materia(ice, '1002', 'Programacion Logica', 4, 10, 3, '1001', ninguno).
materia(ice, '0714', 'Programacion Web', 4, 10, 3, '0711', ninguno).
materia(ice, '0715', 'Mantenimiento Preventivo de PC', 4, 10, 3, ninguno, '0710').
materia(ice, '0510', 'Robotica General', 4, 10, 3, ninguno, '0508').

% Cuatrimestre XI
materia(ice, '0806', 'Administracion Financiera I', 4, 11, 3, '0802', ninguno).
materia(ice, '0717', 'Ingenieria de Software', 4, 11, 3, ninguno, '0714').
materia(ice, '0718', 'Administracion de Centros de Computos', 4, 11, 2, ninguno, ninguno).
materia(ice, '0719', 'Taller de Conectividad', 4, 11, 3, '0713', ninguno).

% Cuatrimestre XII
materia(ice, '1003', 'Inteligencia Artificial', 4, 12, 3, ninguno, '1002').
materia(ice, '0720', 'Tecnologia de Redes Globales', 4, 12, 3, '0719', ninguno).
materia(ice, '0409', 'Sociologia General', 4, 12, 2, ninguno, ninguno).
materia(ice, '0602', 'Formulacion y Evaluacion de Proyectos', 4, 12, 3, ninguno, '0806').

% --- ANO V ---
% Cuatrimestre XIII
materia(ice, '0721', 'Legislacion de las TIC', 5, 13, 2, ninguno, '0718').
materia(ice, '1004', 'Temas Selectos de Cibernetica', 5, 13, 4, ninguno, '1003').
materia(ice, '0604', 'Proyecto de Graduacion I', 5, 13, 3, '0601', ninguno).
materia(ice, '0722', 'Seguridad y Auditoria de Sistemas', 5, 13, 2, ninguno, '0720').

% Cuatrimestre XIV
materia(ice, '0605', 'Proyecto de Graduacion II', 5, 14, 3, '0604', ninguno).
materia(ice, 'ICE-PFP', 'Practicas de Formacion Profesional', 5, 14, 10, ninguno, ninguno).
