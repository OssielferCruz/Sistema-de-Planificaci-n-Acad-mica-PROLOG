% Base de Conocimientos: Plan de Estudios IEM 2026
% Ingenieria Electromedica - Modalidad Presencial
% Formato: materia(Carrera, Codigo, Nombre, Ano, Cuatrimestre, Creditos, Prerrequisito, Precedente).
% Utilizamos 'ninguno' cuando no existe dependencia.
% NOTA: Esta carrera usa codigos con prefijo IEM- y tiene 13 regimenes.

:- discontiguous materia/8.
:- multifile materia/8.

% =====================================================
% ANO I
% =====================================================

% --- Cuatrimestre I ---
materia(iem, 'IEM-0101', 'Redaccion Tecnica', 1, 1, 2, ninguno, ninguno).
materia(iem, 'IEM-0501', 'Matematica I', 1, 1, 3, ninguno, ninguno).
materia(iem, 'IEM-0102', 'Ingles I', 1, 1, 2, ninguno, ninguno).
materia(iem, 'IEM-0601', 'Introduccion Ingenieria Electromedica', 1, 1, 2, ninguno, ninguno).
materia(iem, 'IEM-0901', 'Ofimatica Aplicada', 1, 1, 3, ninguno, ninguno).
materia(iem, 'IEM-0103', 'Identidad Nacional y Orgullo Patrio', 1, 1, 4, ninguno, ninguno).

% --- Cuatrimestre II ---
materia(iem, 'IEM-0104', 'Etica y Lasallismo', 1, 2, 2, ninguno, ninguno).
materia(iem, 'IEM-0902', 'Introduccion a la Programacion', 1, 2, 3, ninguno, ninguno).
materia(iem, 'IEM-0301', 'Fisica I', 1, 2, 3, ninguno, ninguno).
materia(iem, 'IEM-0105', 'Ingles II', 1, 2, 2, ninguno, 'IEM-0102').
materia(iem, 'IEM-0701', 'Gerencia Hospitalaria', 1, 2, 3, ninguno, ninguno).

% --- Cuatrimestre III ---
materia(iem, 'IEM-1106', 'Iglesia, Laicado y Ecumenismo', 1, 3, 2, ninguno, ninguno).
materia(iem, 'IEM-1001', 'Quimica', 1, 3, 3, ninguno, ninguno).
materia(iem, 'IEM-0502', 'Matematica II', 1, 3, 3, 'IEM-0501', ninguno).
materia(iem, 'IEM-0107', 'Ingles III', 1, 3, 2, ninguno, 'IEM-0105').
materia(iem, 'IEM-0903', 'Lenguaje de Programacion I', 1, 3, 3, ninguno, 'IEM-0902').
materia(iem, 'IEM-0108', 'Historia e Identidad Nacional', 1, 3, 3, ninguno, ninguno).

% =====================================================
% ANO II
% =====================================================

% --- Cuatrimestre IV ---
materia(iem, 'IEM-0109', 'Ciudadania, Responsabilidad Social y Ambiental', 2, 4, 2, ninguno, ninguno).
materia(iem, 'IEM-1002', 'Biologia', 2, 4, 3, ninguno, 'IEM-1001').
materia(iem, 'IEM-0401', 'Fisica II', 2, 4, 3, 'IEM-0301', ninguno).
materia(iem, 'IEM-0503', 'Matematica III', 2, 4, 3, 'IEM-0502', ninguno).
materia(iem, 'IEM-0110', 'Ingles IV', 2, 4, 2, ninguno, 'IEM-0107').

% --- Cuatrimestre V ---
materia(iem, 'IEM-0403', 'Generalidades de Instalaciones Electricas', 2, 5, 3, ninguno, ninguno).
materia(iem, 'IEM-0302', 'Estatica', 2, 5, 3, 'IEM-0401', ninguno).
materia(iem, 'IEM-0504', 'Matematica IV', 2, 5, 3, 'IEM-0503', ninguno).
materia(iem, 'IEM-1003', 'Bioquimica', 2, 5, 3, ninguno, 'IEM-1002').
materia(iem, 'IEM-0402', 'Circuitos Electricos I', 2, 5, 3, 'IEM-0401', ninguno).

% --- Cuatrimestre VI ---
materia(iem, 'IEM-0303', 'Dinamica', 2, 6, 3, 'IEM-0302', ninguno).
materia(iem, 'IEM-0703', 'Administracion de la Ingenieria', 2, 6, 2, ninguno, 'IEM-0701').
materia(iem, 'IEM-1004', 'Morfofisiologia I', 2, 6, 3, ninguno, 'IEM-1003').
materia(iem, 'IEM-0702', 'Dibujo y Herramientas CAD', 2, 6, 3, ninguno, ninguno).
materia(iem, 'IEM-0904', 'Lenguaje de Programacion II', 2, 6, 3, 'IEM-0903', ninguno).

% =====================================================
% ANO III
% =====================================================

% --- Cuatrimestre VII ---
materia(iem, 'IEM-0304', 'Termodinamica', 3, 7, 3, ninguno, 'IEM-0303').
materia(iem, 'IEM-0505', 'Metodos Numericos', 3, 7, 3, 'IEM-0504', ninguno).
materia(iem, 'IEM-1005', 'Morfofisiologia II', 3, 7, 4, 'IEM-1004', ninguno).
materia(iem, 'IEM-0602', 'Ingenieria Medica', 3, 7, 3, ninguno, 'IEM-0703').
materia(iem, 'IEM-0404', 'Instalaciones Electricas', 3, 7, 3, ninguno, 'IEM-0402').

% --- Cuatrimestre VIII ---
materia(iem, 'IEM-0305', 'Mecanica de Fluidos', 3, 8, 3, ninguno, 'IEM-0304').
materia(iem, 'IEM-0405', 'Circuitos Electricos II', 3, 8, 2, 'IEM-0402', ninguno).
materia(iem, 'IEM-1006', 'Biofisica', 3, 8, 3, 'IEM-1005', ninguno).
materia(iem, 'IEM-0201', 'Electronica Analogica', 3, 8, 4, 'IEM-0402', ninguno).
materia(iem, 'IEM-0801', 'Bioestadistica', 3, 8, 3, 'IEM-0505', ninguno).

% --- Cuatrimestre IX ---
materia(iem, 'IEM-0202', 'Instrumentacion Biomedica I', 3, 9, 3, 'IEM-1006', ninguno).
materia(iem, 'IEM-0203', 'Electronica Digital', 3, 9, 4, 'IEM-0201', ninguno).
materia(iem, 'IEM-0802', 'Innovacion de Modelos de Negocios y Gestion de Empresas', 3, 9, 3, ninguno, ninguno).
materia(iem, 'IEM-0704', 'Gerencia del Talento Humano', 3, 9, 2, ninguno, 'IEM-0703').
materia(iem, 'IEM-0705', 'Formulacion y Evaluacion de Proyectos', 3, 9, 2, ninguno, 'IEM-0801').

% =====================================================
% ANO IV
% =====================================================

% --- Cuatrimestre X ---
materia(iem, 'IEM-0803', 'Metodologia de la Investigacion', 4, 10, 2, ninguno, 'IEM-0705').
materia(iem, 'IEM-0204', 'Instrumentacion Biomedica II', 4, 10, 3, 'IEM-0202', ninguno).
materia(iem, 'IEM-0603', 'Mediciones Biomedicas I', 4, 10, 3, 'IEM-0202', ninguno).
materia(iem, 'IEM-1007', 'Equipo Electromedico I', 4, 10, 4, 'IEM-0202', ninguno).
materia(iem, 'IEM-0905', 'Microcontroladores y Sistemas Digitales', 4, 10, 3, 'IEM-0203', ninguno).

% --- Cuatrimestre XI ---
materia(iem, 'IEM-0804', 'Proyecto de Graduacion I', 4, 11, 3, 'IEM-0803', ninguno).
materia(iem, 'IEM-0706', 'Sociologia de la Administracion y Organizacion', 4, 11, 2, ninguno, ninguno).
materia(iem, 'IEM-0605', 'Adquisicion y Procesamiento de Senales Medicas', 4, 11, 3, 'IEM-0204', ninguno).
materia(iem, 'IEM-0604', 'Mediciones Biomedicas II', 4, 11, 3, 'IEM-0603', ninguno).
materia(iem, 'IEM-1008', 'Principios de Rehabilitacion', 4, 11, 3, ninguno, 'IEM-1007').

% --- Cuatrimestre XII ---
materia(iem, 'IEM-0607', 'Ampliacion de Senales', 4, 12, 3, ninguno, 'IEM-0605').
materia(iem, 'IEM-1009', 'Equipo Electromedico II', 4, 12, 3, 'IEM-1007', ninguno).
materia(iem, 'IEM-0608', 'Procesamiento Digital de Senales Biomedicas', 4, 12, 3, 'IEM-0605', ninguno).
materia(iem, 'IEM-0906', 'Filtros Analogicos y Digitales', 4, 12, 3, 'IEM-0203', ninguno).

% =====================================================
% ANO V
% =====================================================

% --- Cuatrimestre XIII ---
materia(iem, 'IEM-0805', 'Proyecto de Graduacion II', 5, 13, 3, 'IEM-0804', ninguno).
materia(iem, 'IEMPFP', 'Practicas de Formacion Profesional', 5, 13, 10, ninguno, ninguno).
