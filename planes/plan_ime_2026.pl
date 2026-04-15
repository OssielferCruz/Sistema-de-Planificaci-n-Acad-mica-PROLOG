% Base de Conocimientos: Plan de Estudios IME 2026
% Ingenieria en Mecanica y Energias Renovables - Modalidad Presencial
% Formato: materia(Carrera, Codigo, Nombre, Ano, Cuatrimestre, Creditos, Prerrequisito, Precedente).
% Utilizamos 'ninguno' cuando no existe dependencia.

:- discontiguous materia/8.
:- multifile materia/8.

% =====================================================
% ANO I
% =====================================================

% --- Cuatrimestre I ---
materia(ime, '0401', 'Etica y Lasallismo', 1, 1, 2, ninguno, ninguno).
materia(ime, '0901', 'Introduccion a la Ingenieria', 1, 1, 4, ninguno, ninguno).
materia(ime, '0101', 'Matematica I', 1, 1, 3, ninguno, ninguno).
materia(ime, '0701', 'Ofimatica Aplicada', 1, 1, 3, ninguno, ninguno).
materia(ime, '0402', 'Identidad Nacional y Orgullo Patrio', 1, 1, 4, ninguno, ninguno).

% --- Cuatrimestre II ---
materia(ime, '0903', 'Dibujo Tecnico', 1, 2, 3, ninguno, '0901').
materia(ime, '0403', 'Ingles I', 1, 2, 2, ninguno, ninguno).
materia(ime, '0202', 'Fisica General', 1, 2, 3, ninguno, '0101').
materia(ime, '0102', 'Matematica II', 1, 2, 3, '0101', ninguno).
materia(ime, '0404', 'Redaccion Tecnica', 1, 2, 3, ninguno, ninguno).

% --- Cuatrimestre III ---
materia(ime, '0203', 'Quimica General', 1, 3, 3, ninguno, ninguno).
materia(ime, '0405', 'Ingles II', 1, 3, 2, ninguno, '0403').
materia(ime, '0702', 'Introduccion a la Programacion', 1, 3, 3, ninguno, ninguno).
materia(ime, '0103', 'Matematica III', 1, 3, 3, '0102', ninguno).
materia(ime, '0406', 'Historia e Identidad Nacional', 1, 3, 3, ninguno, ninguno).

% =====================================================
% ANO II
% =====================================================

% --- Cuatrimestre IV ---
materia(ime, '0301', 'Circuitos Electricos', 2, 4, 4, ninguno, '0103').
materia(ime, '0104', 'Matematica IV', 2, 4, 3, '0103', ninguno).
materia(ime, '0105', 'Probabilidad y Estadistica', 2, 4, 3, ninguno, '0103').
materia(ime, '0703', 'Lenguaje de Programacion I', 2, 4, 3, ninguno, '0702').
materia(ime, '0204', 'Estatica', 2, 4, 3, ninguno, '0202').

% --- Cuatrimestre V ---
materia(ime, '0106', 'Analisis Numerico', 2, 5, 3, ninguno, '0703').
materia(ime, '0205', 'Dinamica', 2, 5, 3, ninguno, '0204').
materia(ime, '0206', 'Mecanica de Fluidos', 2, 5, 3, ninguno, '0202').
materia(ime, '0407', 'Ingles III', 2, 5, 2, ninguno, '0405').
materia(ime, '0207', 'Ingenieria de Materiales', 2, 5, 2, ninguno, '0203').

% --- Cuatrimestre VI ---
materia(ime, '0501', 'Electronica Analogica', 2, 6, 4, '0301', ninguno).
materia(ime, '0304', 'Instalaciones Electricas', 2, 6, 3, ninguno, '0301').
materia(ime, '0408', 'Iglesia, Laicado y Ecumenismo', 2, 6, 2, ninguno, '0401').
materia(ime, '1101', 'Bombas y Ventiladores', 2, 6, 3, '0206', ninguno).
materia(ime, '1102', 'Maquinas Herramientas', 2, 6, 3, ninguno, '0207').

% =====================================================
% ANO III
% =====================================================

% --- Cuatrimestre VII ---
materia(ime, '0502', 'Electronica Digital I', 3, 7, 3, ninguno, '0501').
materia(ime, '0503', 'Mando Electromecanico', 3, 7, 3, ninguno, '0301').
materia(ime, '0504', 'Electronica Industrial', 3, 7, 4, ninguno, '0501').
materia(ime, '0209', 'Ingenieria Ambiental I', 3, 7, 2, ninguno, '0203').
materia(ime, '0904', 'Herramientas CAD I', 3, 7, 3, ninguno, '0903').

% --- Cuatrimestre VIII ---
materia(ime, '0505', 'Instrumentacion y Control', 3, 8, 3, ninguno, '0504').
materia(ime, '0305', 'Maquinas Electricas', 3, 8, 3, '0503', ninguno).
materia(ime, '0601', 'Metodologia de la Investigacion', 3, 8, 2, ninguno, '0404').
materia(ime, '0210', 'Termodinamica', 3, 8, 3, ninguno, '0203').
materia(ime, '0905', 'Herramientas CAD II', 3, 8, 3, ninguno, '0904').

% --- Cuatrimestre IX ---
materia(ime, '0508', 'Control Logico Programable', 3, 9, 3, ninguno, '0503').
materia(ime, '0802', 'Principios de Administracion', 3, 9, 3, ninguno, ninguno).
materia(ime, '1103', 'Mecanica de Materiales', 3, 9, 3, ninguno, '0207').
materia(ime, '0509', 'Circuitos Hidraulicos y Neumaticos', 3, 9, 3, '0503', ninguno).
materia(ime, '0211', 'Termodinamica Aplicada', 3, 9, 3, '0210', ninguno).

% =====================================================
% ANO IV
% =====================================================

% --- Cuatrimestre X ---
materia(ime, '0805', 'Seguridad e Higiene Industrial', 4, 10, 3, ninguno, '0802').
materia(ime, '1201', 'Energia Eolica', 4, 10, 3, '0206', ninguno).
materia(ime, '1105', 'Motores de Combustion Interna', 4, 10, 4, ninguno, '0210').
materia(ime, '0907', 'Introduccion al Diseno Mecanico', 4, 10, 3, '1103', ninguno).
materia(ime, '1106', 'Transferencia de Calor', 4, 10, 3, '0211', ninguno).

% --- Cuatrimestre XI ---
materia(ime, '0806', 'Administracion Financiera I', 4, 11, 3, ninguno, '0802').
materia(ime, '0807', 'Administracion del Mantenimiento', 4, 11, 3, ninguno, '0802').
materia(ime, '1202', 'Energia Solar', 4, 11, 3, '0304', ninguno).
materia(ime, '0909', 'Diseno de Elementos de Maquinas', 4, 11, 3, ninguno, '0907').
materia(ime, '1107', 'Maquinas Termicas', 4, 11, 3, '0211', ninguno).

% --- Cuatrimestre XII ---
materia(ime, '0602', 'Formulacion y Evaluacion de Proyectos', 4, 12, 3, '0806', ninguno).
materia(ime, '1108', 'Eficiencia Energetica', 4, 12, 3, ninguno, '0211').
materia(ime, '1203', 'Energia Geotermica', 4, 12, 3, ninguno, '1107').

% =====================================================
% ANO V
% =====================================================

% --- Cuatrimestre XIII ---
materia(ime, '0604', 'Proyecto de Graduacion I', 5, 13, 3, '0601', ninguno).
materia(ime, '1204', 'Refrigeracion Industrial', 5, 13, 3, ninguno, '1106').
materia(ime, '0912', 'Diseno de Equipos de Proceso', 5, 13, 3, ninguno, '0907').
materia(ime, '1205', 'Plantas Hidroelectricas', 5, 13, 3, '1101', ninguno).

% --- Cuatrimestre XIV ---
materia(ime, '0605', 'Proyecto de Graduacion II', 5, 14, 3, '0604', ninguno).
materia(ime, 'IMEPFP', 'Practicas de Formacion Profesional', 5, 14, 10, ninguno, ninguno).
