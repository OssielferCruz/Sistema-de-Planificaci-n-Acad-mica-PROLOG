% Base de Conocimientos: Plan de Estudios IMS 2026
% Ingenieria en Mecatronica y Sistemas de Control - Modalidad Presencial
% Formato: materia(Carrera, Codigo, Nombre, Ano, Cuatrimestre, Creditos, Prerrequisito, Precedente).
% Utilizamos 'ninguno' cuando no existe dependencia.

:- discontiguous materia/8.
:- multifile materia/8.

% =====================================================
% ANO I
% =====================================================

% --- Cuatrimestre I ---
materia(ims, '0401', 'Etica y Lasallismo', 1, 1, 2, ninguno, ninguno).
materia(ims, '0901', 'Introduccion a la Ingenieria', 1, 1, 4, ninguno, ninguno).
materia(ims, '0101', 'Matematica I', 1, 1, 3, ninguno, ninguno).
materia(ims, '0701', 'Ofimatica Aplicada', 1, 1, 3, ninguno, ninguno).
materia(ims, '0402', 'Identidad Nacional y Orgullo Patrio', 1, 1, 4, ninguno, ninguno).

% --- Cuatrimestre II ---
materia(ims, '0903', 'Dibujo Tecnico', 1, 2, 3, ninguno, '0901').
materia(ims, '0403', 'Ingles I', 1, 2, 2, ninguno, ninguno).
materia(ims, '0201', 'Fisica', 1, 2, 4, ninguno, '0101').
materia(ims, '0102', 'Matematica II', 1, 2, 3, '0101', ninguno).
materia(ims, '0404', 'Redaccion Tecnica', 1, 2, 3, ninguno, ninguno).

% --- Cuatrimestre III ---
materia(ims, '0203', 'Quimica General', 1, 3, 3, ninguno, ninguno).
materia(ims, '0405', 'Ingles II', 1, 3, 2, ninguno, '0403').
materia(ims, '0702', 'Introduccion a la Programacion', 1, 3, 3, ninguno, ninguno).
materia(ims, '0103', 'Matematica III', 1, 3, 3, '0102', ninguno).
materia(ims, '0406', 'Historia e Identidad Nacional', 1, 3, 3, ninguno, ninguno).

% =====================================================
% ANO II
% =====================================================

% --- Cuatrimestre IV ---
materia(ims, '0302', 'Circuitos Electricos I', 2, 4, 3, '0103', ninguno).
materia(ims, '0104', 'Matematica IV', 2, 4, 3, '0103', ninguno).
materia(ims, '0703', 'Lenguaje de Programacion I', 2, 4, 3, ninguno, '0702').
materia(ims, '0105', 'Probabilidad y Estadistica', 2, 4, 3, ninguno, '0103').
materia(ims, '0204', 'Estatica', 2, 4, 3, ninguno, '0201').

% --- Cuatrimestre V ---
materia(ims, '0106', 'Analisis Numerico', 2, 5, 3, ninguno, '0703').
materia(ims, '0407', 'Ingles III', 2, 5, 2, ninguno, '0405').
materia(ims, '0303', 'Circuitos Electricos II', 2, 5, 4, '0302', ninguno).
materia(ims, '0107', 'Investigacion de Operaciones I', 2, 5, 3, ninguno, '0105').
materia(ims, '0205', 'Dinamica', 2, 5, 3, ninguno, '0204').

% --- Cuatrimestre VI ---
materia(ims, '0501', 'Electronica Analogica', 2, 6, 4, '0303', ninguno).
materia(ims, '0208', 'Ciencia e Ingenieria de Materiales', 2, 6, 4, ninguno, '0203').
materia(ims, '0408', 'Iglesia, Laicado y Ecumenismo', 2, 6, 2, ninguno, '0401').
materia(ims, '0304', 'Instalaciones Electricas', 2, 6, 3, '0302', ninguno).
materia(ims, '0705', 'Lenguaje de Programacion II', 2, 6, 3, '0703', ninguno).

% =====================================================
% ANO III
% =====================================================

% --- Cuatrimestre VII ---
materia(ims, '0502', 'Electronica Digital I', 3, 7, 3, ninguno, '0501').
materia(ims, '0503', 'Mando Electromecanico', 3, 7, 3, '0304', ninguno).
materia(ims, '0504', 'Electronica Industrial', 3, 7, 4, ninguno, '0501').
materia(ims, '0209', 'Ingenieria Ambiental I', 3, 7, 2, ninguno, '0203').
materia(ims, '0904', 'Herramientas CAD I', 3, 7, 3, '0903', ninguno).

% --- Cuatrimestre VIII ---
materia(ims, '0505', 'Instrumentacion y Control', 3, 8, 3, '0504', ninguno).
materia(ims, '0506', 'Electronica Digital II', 3, 8, 4, '0502', ninguno).
materia(ims, '0210', 'Termodinamica', 3, 8, 3, ninguno, '0203').
materia(ims, '0601', 'Metodologia de la Investigacion', 3, 8, 2, ninguno, '0404').
materia(ims, '0905', 'Herramientas CAD II', 3, 8, 3, '0904', ninguno).

% --- Cuatrimestre IX ---
materia(ims, '0508', 'Control Logico Programable', 3, 9, 3, '0503', ninguno).
materia(ims, '0109', 'Modelos de Simulacion', 3, 9, 3, '0107', ninguno).
materia(ims, '0708', 'Estructura de Datos y Organizacion de Archivos', 3, 9, 4, ninguno, '0705').
materia(ims, '0802', 'Principios de Administracion', 3, 9, 3, ninguno, ninguno).
materia(ims, '0509', 'Circuitos Hidraulicos y Neumaticos', 3, 9, 3, '0503', ninguno).

% =====================================================
% ANO IV
% =====================================================

% --- Cuatrimestre X ---
materia(ims, '0907', 'Introduccion al Diseno Mecanico', 4, 10, 3, ninguno, '0208').
materia(ims, '0805', 'Seguridad e Higiene Industrial', 4, 10, 3, ninguno, '0802').
materia(ims, '0511', 'Sistemas de Control Dinamico', 4, 10, 3, ninguno, '0505').
materia(ims, '0716', 'Lenguaje de Programacion III', 4, 10, 3, '0705', ninguno).
materia(ims, '0306', 'Maquinas Electricas Estaticas', 4, 10, 4, '0503', ninguno).

% --- Cuatrimestre XI ---
materia(ims, '0806', 'Administracion Financiera I', 4, 11, 3, ninguno, '0802').
materia(ims, '0807', 'Administracion del Mantenimiento', 4, 11, 3, ninguno, '0802').
materia(ims, '0908', 'Control Numerico Computarizado', 4, 11, 3, '0905', ninguno).
materia(ims, '0307', 'Maquinas Electricas Rotativas', 4, 11, 3, '0306', ninguno).
materia(ims, '0909', 'Diseno de Elementos de Maquinas', 4, 11, 3, ninguno, '0907').

% --- Cuatrimestre XII ---
materia(ims, '0602', 'Formulacion y Evaluacion de Proyectos', 4, 12, 3, '0806', ninguno).
materia(ims, '0910', 'Manufactura Integrada por Computadora', 4, 12, 3, '0908', ninguno).
materia(ims, '0513', 'Robotica Basica', 4, 12, 3, '0908', ninguno).

% =====================================================
% ANO V
% =====================================================

% --- Cuatrimestre XIII ---
materia(ims, '0514', 'Sistema de Identificacion Automatica', 5, 13, 3, '0716', ninguno).
materia(ims, '0604', 'Proyecto de Graduacion I', 5, 13, 3, '0601', ninguno).
materia(ims, '0515', 'Robotica Avanzada', 5, 13, 4, '0513', ninguno).
materia(ims, '0911', 'Analisis y Diseno de Sistemas Mecatronicos', 5, 13, 3, '0511', ninguno).

% --- Cuatrimestre XIV ---
materia(ims, '0605', 'Proyecto de Graduacion II', 5, 14, 3, '0604', ninguno).
materia(ims, 'IMSPFP', 'Practicas de Formacion Profesional', 5, 14, 10, ninguno, ninguno).
