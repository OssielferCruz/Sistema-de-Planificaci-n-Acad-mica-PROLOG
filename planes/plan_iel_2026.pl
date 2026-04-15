% Base de Conocimientos: Plan de Estudios IEL 2026
% Ingenieria Electrica - Modalidad Semipresencial (Trimestral)
% Formato: materia(Carrera, Codigo, Nombre, Ano, Trimestre, Creditos, Prerrequisito, Precedente).
% Utilizamos 'ninguno' cuando no existe dependencia.

:- discontiguous materia/8.
:- multifile materia/8.

% =====================================================
% ANO I
% =====================================================

% --- Trimestre I ---
materia(iel, 'IEL0901', 'Algebra Lineal y Matrices', 1, 1, 3, ninguno, ninguno).
materia(iel, 'IEL0602', 'Introduccion a la Ingenieria', 1, 1, 3, ninguno, ninguno).
materia(iel, 'IEL0601', 'Etica y Lasallismo', 1, 1, 2, ninguno, ninguno).
materia(iel, 'IEL0603', 'Identidad Nacional y Orgullo Patrio', 1, 1, 4, ninguno, ninguno).

% --- Trimestre II ---
materia(iel, 'IEL0902', 'Matematica I', 1, 2, 4, ninguno, ninguno).
materia(iel, 'IEL0801', 'Redaccion Tecnica para Ingenieria', 1, 2, 3, ninguno, ninguno).
materia(iel, 'IEL1001', 'Ofimatica Aplicada', 1, 2, 3, ninguno, ninguno).
materia(iel, 'IEL0604', 'Teologia y Laicado', 1, 2, 2, ninguno, ninguno).

% --- Trimestre III ---
materia(iel, 'IEL0903', 'Matematica II', 1, 3, 4, 'IEL0902', ninguno).
materia(iel, 'IEL0303', 'Introduccion al Taller Electrico', 1, 3, 3, ninguno, 'IEL0602').
materia(iel, 'IEL0401', 'Fisica I', 1, 3, 4, ninguno, 'IEL0902').

% --- Trimestre IV ---
materia(iel, 'IEL0402', 'Estatica', 1, 4, 3, ninguno, 'IEL0401').
materia(iel, 'IEL0904', 'Matematica III', 1, 4, 4, 'IEL0903', ninguno).
materia(iel, 'IEL0101', 'Ingles I', 1, 4, 2, ninguno, ninguno).
materia(iel, 'IEL0605', 'Historia e Identidad Nacional', 1, 4, 3, ninguno, ninguno).

% =====================================================
% ANO II
% =====================================================

% --- Trimestre V ---
materia(iel, 'IEL0905', 'Matematica IV', 2, 5, 4, 'IEL0904', ninguno).
materia(iel, 'IEL0403', 'Dinamica', 2, 5, 3, 'IEL0402', ninguno).
materia(iel, 'IEL0102', 'Ingles II', 2, 5, 2, ninguno, 'IEL0101').

% --- Trimestre VI ---
materia(iel, 'IEL0104', 'Dibujo General', 2, 6, 3, ninguno, 'IEL0303').
materia(iel, 'IEL0404', 'Fisica II: Electricidad y Magnetismo', 2, 6, 4, ninguno, 'IEL0401').
materia(iel, 'IEL0103', 'Ingles III', 2, 6, 2, ninguno, 'IEL0102').

% --- Trimestre VII ---
materia(iel, 'IEL0301', 'Circuitos Electricos I', 2, 7, 4, 'IEL0404', ninguno).
materia(iel, 'IEL1002', 'Introduccion a la Programacion', 2, 7, 3, ninguno, ninguno).
materia(iel, 'IEL1101', 'Quimica General', 2, 7, 3, ninguno, ninguno).

% --- Trimestre VIII ---
materia(iel, 'IEL0302', 'Circuitos Electricos II', 2, 8, 4, 'IEL0301', ninguno).
materia(iel, 'IEL1003', 'Lenguaje de Programacion I', 2, 8, 3, ninguno, 'IEL1002').
materia(iel, 'IEL0906', 'Probabilidad y Estadistica', 2, 8, 3, ninguno, 'IEL0905').

% =====================================================
% ANO III
% =====================================================

% --- Trimestre IX ---
materia(iel, 'IEL0105', 'Herramientas CAD Electrical', 3, 9, 3, 'IEL0104', ninguno).
materia(iel, 'IEL0201', 'Electronica Analogica', 3, 9, 4, 'IEL0302', ninguno).
materia(iel, 'IEL1102', 'Conocimiento de Materiales Electricos', 3, 9, 3, ninguno, 'IEL1101').

% --- Trimestre X ---
materia(iel, 'IEL1201', 'Instalaciones Electricas I', 3, 10, 3, ninguno, 'IEL0302').
materia(iel, 'IEL1202', 'Maquinas Electricas I', 3, 10, 3, 'IEL0302', ninguno).
materia(iel, 'IEL0202', 'Electronica de Potencia', 3, 10, 4, 'IEL0201', ninguno).

% --- Trimestre XI ---
materia(iel, 'IEL0405', 'Termodinamica', 3, 11, 3, ninguno, 'IEL1101').
materia(iel, 'IEL0203', 'Electronica Digital', 3, 11, 4, ninguno, 'IEL0201').
materia(iel, 'IEL1203', 'Maquinas Electricas II', 3, 11, 3, 'IEL1202', ninguno).

% --- Trimestre XII ---
materia(iel, 'IEL0701', 'Instrumentacion Industrial', 3, 12, 4, 'IEL0202', ninguno).
materia(iel, 'IEL1204', 'Maquinas Electricas III', 3, 12, 3, 'IEL1203', ninguno).
materia(iel, 'IEL0702', 'Controles Electricos', 3, 12, 3, ninguno, 'IEL1203').

% =====================================================
% ANO IV
% =====================================================

% --- Trimestre XIII ---
materia(iel, 'IEL0501', 'Administracion del Mantenimiento', 4, 13, 3, ninguno, 'IEL0906').
materia(iel, 'IEL1205', 'Instalaciones Electricas II', 4, 13, 4, 'IEL1201', ninguno).
materia(iel, 'IEL0802', 'Metodologia de la Investigacion', 4, 13, 3, ninguno, 'IEL0906').

% --- Trimestre XIV ---
materia(iel, 'IEL0703', 'Control Electrohidraulico y Electroneumatico', 4, 14, 3, 'IEL0702', ninguno).
materia(iel, 'IEL0502', 'Administracion en la Ingenieria', 4, 14, 3, ninguno, 'IEL0501').
materia(iel, 'IEL1206', 'Sistemas Electricos de Potencia I', 4, 14, 3, 'IEL1204', ninguno).

% --- Trimestre XV ---
materia(iel, 'IEL0704', 'Control Logico Programable', 4, 15, 3, ninguno, 'IEL0203').
materia(iel, 'IEL0503', 'Formulacion y Evaluacion de Proyectos', 4, 15, 3, ninguno, 'IEL0502').
materia(iel, 'IEL1207', 'Sistemas Electricos de Potencia II', 4, 15, 4, 'IEL1206', ninguno).

% --- Trimestre XVI ---
materia(iel, 'IEL0803', 'Proyecto de Graduacion I', 4, 16, 3, ninguno, 'IEL0503').
materia(iel, 'IEL0705', 'Sistema de Control Moderno', 4, 16, 3, 'IEL0704', ninguno).
materia(iel, 'IEL1208', 'Redes de Distribucion Electrica', 4, 16, 4, 'IEL1207', ninguno).

% =====================================================
% ANO V
% =====================================================

% --- Trimestre XVII ---
materia(iel, 'IEL1209', 'Tecnicas de Alta Tension', 5, 17, 4, ninguno, 'IEL1206').
materia(iel, 'IEL0504', 'Mantenimiento de Redes Electricas en Mediana Tension', 5, 17, 4, 'IEL1208', ninguno).
materia(iel, 'IEL1210', 'Diseno de Subestaciones Electricas', 5, 17, 4, 'IEL1208', ninguno).

% --- Trimestre XVIII ---
materia(iel, 'IEL0804', 'Proyecto de Graduacion II', 5, 18, 3, 'IEL0803', ninguno).
materia(iel, 'IEL0606', 'Sociologia de la Administracion y la Organizacion', 5, 18, 3, ninguno, ninguno).
materia(iel, 'IEL1211', 'Proteccion de Sistemas Electricos de Potencia', 5, 18, 4, 'IEL1210', ninguno).

% --- Trimestre XIX ---
materia(iel, 'IELPFP', 'Practicas de Formacion Profesional', 5, 19, 10, ninguno, ninguno).
