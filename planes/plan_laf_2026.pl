% Base de Conocimientos: Plan de Estudios LAF 2026
% Licenciatura en Administracion con Enfasis en Finanzas - Modalidad Presencial
% Formato: materia(Carrera, Codigo, Nombre, Ano, Cuatrimestre, Creditos, Prerrequisito, Precedente).
% Utilizamos 'ninguno' cuando no existe dependencia.

:- discontiguous materia/8.
:- multifile materia/8.

% =====================================================
% ANO I
% =====================================================

% --- Cuatrimestre I ---
materia(laf, 'LAF0201', 'Algebra Lineal', 1, 1, 3, ninguno, ninguno).
materia(laf, 'LAF0101', 'Etica y Lasallismo', 1, 1, 2, ninguno, ninguno).
materia(laf, 'LAF0102', 'Ofimatica', 1, 1, 3, ninguno, ninguno).
materia(laf, 'LAF0103', 'Ingles I', 1, 1, 3, ninguno, ninguno).
materia(laf, 'LAF0104', 'Identidad Nacional y Orgullo Patrio', 1, 1, 4, ninguno, ninguno).

% --- Cuatrimestre II ---
materia(laf, 'LAF0105', 'Redaccion Tecnica', 1, 2, 3, ninguno, ninguno).
materia(laf, 'LAF0202', 'Modelos Matematicos Aplicados a los Negocios', 1, 2, 3, ninguno, ninguno).
materia(laf, 'LAF0301', 'Administracion General', 1, 2, 3, ninguno, ninguno).
materia(laf, 'LAF0401', 'Contabilidad I', 1, 2, 3, ninguno, ninguno).
materia(laf, 'LAF0106', 'Ingles II', 1, 2, 3, ninguno, 'LAF0103').

% --- Cuatrimestre III ---
materia(laf, 'LAF0501', 'Mercadeo I', 1, 3, 3, ninguno, ninguno).
materia(laf, 'LAF0203', 'Matematica Financiera I', 1, 3, 3, 'LAF0202', ninguno).
materia(laf, 'LAF0107', 'Historia e Identidad Nacional', 1, 3, 3, ninguno, ninguno).
materia(laf, 'LAF0402', 'Contabilidad II', 1, 3, 3, 'LAF0401', ninguno).
materia(laf, 'LAF0108', 'Ingles III', 1, 3, 3, ninguno, 'LAF0106').

% =====================================================
% ANO II
% =====================================================

% --- Cuatrimestre IV ---
materia(laf, 'LAF0502', 'Mercadeo II', 2, 4, 3, 'LAF0501', ninguno).
materia(laf, 'LAF0204', 'Matematica Financiera II', 2, 4, 3, 'LAF0203', ninguno).
materia(laf, 'LAF0205', 'Estadistica Descriptiva para la Administracion', 2, 4, 3, 'LAF0202', ninguno).
materia(laf, 'LAF0601', 'Etica Financiera y Responsabilidad Social Corporativa en Finanzas', 2, 4, 3, ninguno, ninguno).
materia(laf, 'LAF0109', 'Ingles IV', 2, 4, 3, ninguno, 'LAF0108').

% --- Cuatrimestre V ---
materia(laf, 'LAF0701', 'Tecnologia Fintech', 2, 5, 3, 'LAF0201', ninguno).
materia(laf, 'LAF0206', 'Estadistica Inferencial para la Administracion', 2, 5, 3, 'LAF0205', ninguno).
materia(laf, 'LAF0801', 'Microeconomia', 2, 5, 3, ninguno, ninguno).
materia(laf, 'LAF0207', 'Simulacion y Modelado de Decisiones', 2, 5, 3, 'LAF0202', ninguno).
materia(laf, 'LAF0403', 'Contabilidad de Costos', 2, 5, 3, 'LAF0402', ninguno).

% =====================================================
% ANO III
% =====================================================

% --- Cuatrimestre VI ---
materia(laf, 'LAF0602', 'Gestion del Talento Humano', 3, 6, 3, 'LAF0301', ninguno).
materia(laf, 'LAF0802', 'Macroeconomia', 3, 6, 3, 'LAF0801', ninguno).
materia(laf, 'LAF0901', 'Derecho Mercantil', 3, 6, 3, ninguno, ninguno).
materia(laf, 'LAF0503', 'Politica de Costos y Precios', 3, 6, 3, 'LAF0403', ninguno).
materia(laf, 'LAF0404', 'Administracion Financiera', 3, 6, 3, ninguno, 'LAF0402').

% --- Cuatrimestre VII ---
materia(laf, 'LAF0702', 'Fundamentos de Base de Datos', 3, 7, 3, ninguno, ninguno).
materia(laf, 'LAF0902', 'Derecho Laboral', 3, 7, 3, ninguno, ninguno).
materia(laf, 'LAF0302', 'Planificacion Estrategica', 3, 7, 2, ninguno, 'LAF0301').
materia(laf, 'LAF0405', 'Finanzas Especiales', 3, 7, 3, 'LAF0404', ninguno).
materia(laf, 'LAF0703', 'Analisis de Datos Financieros', 3, 7, 3, ninguno, 'LAF0701').

% --- Cuatrimestre VIII ---
materia(laf, 'LAF0704', 'Aplicaciones de Bases de Datos', 3, 8, 3, 'LAF0702', ninguno).
materia(laf, 'LAF0505', 'Investigacion de Mercados', 3, 8, 3, 'LAF0502', ninguno).
materia(laf, 'LAF0406', 'Finanzas Corporativas', 3, 8, 3, 'LAF0405', ninguno).
materia(laf, 'LAF0303', 'Direccion Estrategica', 3, 8, 3, 'LAF0302', ninguno).
materia(laf, 'LAF1001', 'Metodologia de la Investigacion', 3, 8, 3, ninguno, 'LAF0206').

% =====================================================
% ANO IV
% =====================================================

% --- Cuatrimestre IX ---
materia(laf, 'LAF0506', 'Gestion Estrategica de la Cadena de Suministro', 4, 9, 3, ninguno, 'LAF0303').
materia(laf, 'LAF0407', 'Dinero y Bancos', 4, 9, 3, ninguno, 'LAF0802').
materia(laf, 'LAF0304', 'Teoria de la Decision', 4, 9, 3, 'LAF0303', ninguno).
materia(laf, 'LAF0903', 'Derecho Tributario y Aduanero', 4, 9, 3, ninguno, 'LAF0901').
materia(laf, 'LAF0408', 'Decisiones de Financiamiento e Inversion I', 4, 9, 3, 'LAF0406', ninguno).

% --- Cuatrimestre X ---
materia(laf, 'LAF0508', 'Comportamiento del Consumidor', 4, 10, 3, ninguno, 'LAF0505').
materia(laf, 'LAF1002', 'Marca Personal y Emprendimiento', 4, 10, 2, 'LAF0505', ninguno).
materia(laf, 'LAF1003', 'Formulacion y Evaluacion de Proyectos', 4, 10, 3, ninguno, 'LAF0505').
materia(laf, 'LAF0305', 'Administracion de Operaciones', 4, 10, 3, ninguno, 'LAF0303').
materia(laf, 'LAF0409', 'Decisiones de Financiamiento e Inversion II', 4, 10, 3, 'LAF0408', ninguno).

% --- Cuatrimestre XI ---
materia(laf, 'LAF0110', 'Iglesia Laicado y Ecumenismo', 4, 11, 2, ninguno, 'LAF0101').
materia(laf, 'LAF1004', 'Innovacion de Modelos de Negocios y Gestion de Empresas', 4, 11, 3, ninguno, 'LAF1002').
materia(laf, 'LAF0410', 'Diagnostico Financiero de Empresas', 4, 11, 3, 'LAF0406', ninguno).
materia(laf, 'LAF1005', 'Gerencia de Proyectos', 4, 11, 3, 'LAF1003', ninguno).
materia(laf, 'LAF0511', 'Comercio Internacional', 4, 11, 3, ninguno, 'LAF0903').

% --- Cuatrimestre XII ---
materia(laf, 'LAF1006', 'Proyecto de Graduacion I', 4, 12, 3, 'LAF1003', ninguno).
materia(laf, 'LAF0603', 'Psicologia Organizacional e Industrial', 4, 12, 2, ninguno, 'LAF0602').
materia(laf, 'LAF0411', 'Sistema Financiero Global', 4, 12, 3, 'LAF0407', ninguno).
materia(laf, 'LAF0705', 'Inteligencia Artificial Aplicada a los Negocios', 4, 12, 2, ninguno, 'LAF0704').

% =====================================================
% ANO V
% =====================================================

% --- Cuatrimestre XIII ---
materia(laf, 'LAF1007', 'Proyecto de Graduacion II', 5, 13, 3, 'LAF1006', ninguno).
materia(laf, 'LAFPFP', 'Practicas de Formacion Profesional', 5, 13, 10, ninguno, ninguno).
