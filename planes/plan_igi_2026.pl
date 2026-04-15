% Base de Conocimientos: Plan de Estudios IGI 2026
% Ingenieria en Gestion Industrial - Modalidad Presencial
% Formato: materia(Carrera, Codigo, Nombre, Ano, Cuatrimestre, Creditos, Prerrequisito, Precedente).
% Utilizamos 'ninguno' cuando no existe dependencia.

:- discontiguous materia/8.
:- multifile materia/8.

% =====================================================
% ANO I
% =====================================================

% --- Cuatrimestre I ---
materia(igi, '0401', 'Etica y Lasallismo', 1, 1, 2, ninguno, ninguno).
materia(igi, '0901', 'Introduccion a la Ingenieria', 1, 1, 4, ninguno, ninguno).
materia(igi, '0101', 'Matematica I', 1, 1, 3, ninguno, ninguno).
materia(igi, '0701', 'Ofimatica Aplicada', 1, 1, 3, ninguno, ninguno).
materia(igi, '0402', 'Identidad Nacional y Orgullo Patrio', 1, 1, 4, ninguno, ninguno).

% --- Cuatrimestre II ---
materia(igi, '0903', 'Dibujo Tecnico', 1, 2, 3, ninguno, '0901').
materia(igi, '0403', 'Ingles I', 1, 2, 2, ninguno, ninguno).
materia(igi, '0404', 'Redaccion Tecnica', 1, 2, 3, ninguno, ninguno).
materia(igi, '0202', 'Fisica General', 1, 2, 3, ninguno, '0101').
materia(igi, '0102', 'Matematica II', 1, 2, 3, '0101', ninguno).

% --- Cuatrimestre III ---
materia(igi, '0203', 'Quimica General', 1, 3, 3, ninguno, ninguno).
materia(igi, '0405', 'Ingles II', 1, 3, 2, ninguno, '0403').
materia(igi, '0702', 'Introduccion a la Programacion', 1, 3, 3, ninguno, ninguno).
materia(igi, '0103', 'Matematica III', 1, 3, 3, '0102', ninguno).
materia(igi, '0406', 'Historia e Identidad Nacional', 1, 3, 3, ninguno, ninguno).

% =====================================================
% ANO II
% =====================================================

% --- Cuatrimestre IV ---
materia(igi, '0104', 'Matematica IV', 2, 4, 3, '0103', ninguno).
materia(igi, '0703', 'Lenguaje de Programacion I', 2, 4, 3, ninguno, '0702').
materia(igi, '0204', 'Estatica', 2, 4, 3, ninguno, '0202').
materia(igi, '0301', 'Circuitos Electricos', 2, 4, 4, ninguno, '0103').
materia(igi, '0105', 'Probabilidad y Estadistica', 2, 4, 3, ninguno, '0103').

% --- Cuatrimestre V ---
materia(igi, '0106', 'Analisis Numerico', 2, 5, 3, ninguno, '0703').
materia(igi, '0704', 'Analitica y Visualizacion de Datos', 2, 5, 3, ninguno, '0105').
materia(igi, '0407', 'Ingles III', 2, 5, 2, ninguno, '0405').
materia(igi, '0205', 'Dinamica', 2, 5, 3, '0204', ninguno).
materia(igi, '0107', 'Investigacion de Operaciones I', 2, 5, 3, ninguno, '0105').

% --- Cuatrimestre VI ---
materia(igi, '0501', 'Electronica Analogica', 2, 6, 4, '0301', ninguno).
materia(igi, '0408', 'Iglesia, Laicado y Ecumenismo', 2, 6, 2, ninguno, '0401').
materia(igi, '0304', 'Instalaciones Electricas', 2, 6, 3, ninguno, '0301').
materia(igi, '0904', 'Herramientas CAD I', 2, 6, 3, '0903', ninguno).
materia(igi, '0208', 'Ciencia e Ingenieria de Materiales', 2, 6, 4, ninguno, '0203').

% =====================================================
% ANO III
% =====================================================

% --- Cuatrimestre VII ---
materia(igi, '0502', 'Electronica Digital I', 3, 7, 3, ninguno, '0501').
materia(igi, '0503', 'Mando Electromecanico', 3, 7, 3, '0304', ninguno).
materia(igi, '0209', 'Ingenieria Ambiental I', 3, 7, 2, ninguno, '0203').
materia(igi, '0504', 'Electronica Industrial', 3, 7, 4, ninguno, '0501').
materia(igi, '0108', 'Investigacion de Operaciones II', 3, 7, 3, '0107', ninguno).

% --- Cuatrimestre VIII ---
materia(igi, '0505', 'Instrumentacion y Control', 3, 8, 3, '0504', ninguno).
materia(igi, '0210', 'Termodinamica', 3, 8, 3, ninguno, '0203').
materia(igi, '0305', 'Maquinas Electricas', 3, 8, 3, '0503', ninguno).
materia(igi, '0601', 'Metodologia de la Investigacion', 3, 8, 2, ninguno, '0404').
materia(igi, '0801', 'Ingenieria de Metodos', 3, 8, 3, ninguno, '0105').

% --- Cuatrimestre IX ---
materia(igi, '0507', 'Sistemas de Control', 3, 9, 3, '0505', ninguno).
materia(igi, '0508', 'Control Logico Programable', 3, 9, 3, ninguno, '0503').
materia(igi, '1104', 'Tecnologia de Motores de Combustion Interna', 3, 9, 3, ninguno, '0210').
materia(igi, '0109', 'Modelos de Simulacion', 3, 9, 3, '0107', ninguno).
materia(igi, '0509', 'Circuitos Hidraulicos y Neumaticos', 3, 9, 3, '0503', ninguno).

% =====================================================
% ANO IV
% =====================================================

% --- Cuatrimestre X ---
materia(igi, '0803', 'Gestion de la Cadena de Suministro', 4, 10, 2, '0107', ninguno).
materia(igi, '0906', 'Introduccion al Control Numerico', 4, 10, 3, '0904', ninguno).
materia(igi, '0804', 'Gestion de la Calidad', 4, 10, 3, ninguno, ninguno).
materia(igi, '0212', 'Ingenieria Ambiental II', 4, 10, 2, ninguno, '0209').
materia(igi, '0805', 'Seguridad e Higiene Industrial', 4, 10, 3, ninguno, '0801').

% --- Cuatrimestre XI ---
materia(igi, '0807', 'Administracion del Mantenimiento', 4, 11, 3, ninguno, ninguno).
materia(igi, '0808', 'Planeacion y Control de la Produccion', 4, 11, 3, '0801', ninguno).
materia(igi, '0809', 'Economia General', 4, 11, 4, ninguno, ninguno).
materia(igi, '0810', 'Mercadotecnia', 4, 11, 2, ninguno, ninguno).
materia(igi, '0512', 'Generalidades de Sistemas de Identificacion Automatica', 4, 11, 2, '0109', ninguno).

% --- Cuatrimestre XII ---
materia(igi, '0602', 'Formulacion y Evaluacion de Proyecto', 4, 12, 3, ninguno, '0808').
materia(igi, '0603', 'Innovacion y Emprendimiento', 4, 12, 3, '0810', ninguno).
materia(igi, '0811', 'Gestion de Talento Humano', 4, 12, 2, ninguno, ninguno).

% =====================================================
% ANO V
% =====================================================

% --- Cuatrimestre XIII ---
materia(igi, '0604', 'Proyecto de Graduacion I', 5, 13, 3, '0601', ninguno).
materia(igi, '0410', 'Derecho Laboral', 5, 13, 2, ninguno, '0811').
materia(igi, '0812', 'Sistemas Integrados de Gestion', 5, 13, 3, ninguno, '0805').
materia(igi, '0813', 'Ingenieria Economica', 5, 13, 3, '0809', ninguno).

% --- Cuatrimestre XIV ---
materia(igi, '0605', 'Proyecto de Graduacion II', 5, 14, 3, '0604', ninguno).
materia(igi, 'IGIPFP', 'Practicas de Formacion Profesional', 5, 14, 10, ninguno, ninguno).
