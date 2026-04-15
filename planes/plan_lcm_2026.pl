% Base de Conocimientos: Plan de Estudios LCM 2026
% Licenciatura Comercial con Enfasis en Mercadeo - Modalidad Presencial
% Formato: materia(Carrera, Codigo, Nombre, Ano, Cuatrimestre, Creditos, Prerrequisito, Precedente).
% Utilizamos 'ninguno' cuando no existe dependencia.

:- discontiguous materia/8.
:- multifile materia/8.

% =====================================================
% ANO I
% =====================================================

% --- Cuatrimestre I ---
materia(lcm, 'LCM0201', 'Algebra Lineal', 1, 1, 3, ninguno, ninguno).
materia(lcm, 'LCM0101', 'Etica y Lasallismo', 1, 1, 2, ninguno, ninguno).
materia(lcm, 'LCM0102', 'Ofimatica', 1, 1, 3, ninguno, ninguno).
materia(lcm, 'LCM0103', 'Ingles I', 1, 1, 3, ninguno, ninguno).
materia(lcm, 'LCM0104', 'Identidad Nacional y Orgullo Patrio', 1, 1, 4, ninguno, ninguno).

% --- Cuatrimestre II ---
materia(lcm, 'LCM0105', 'Redaccion Tecnica', 1, 2, 3, ninguno, ninguno).
materia(lcm, 'LCM0202', 'Modelos Matematicos Aplicados a los Negocios', 1, 2, 3, ninguno, ninguno).
materia(lcm, 'LCM0301', 'Administracion General', 1, 2, 3, ninguno, ninguno).
materia(lcm, 'LCM0401', 'Contabilidad I', 1, 2, 3, ninguno, ninguno).
materia(lcm, 'LCM0106', 'Ingles II', 1, 2, 3, ninguno, 'LCM0103').

% --- Cuatrimestre III ---
materia(lcm, 'LCM0501', 'Mercadeo I', 1, 3, 3, ninguno, ninguno).
materia(lcm, 'LCM0203', 'Matematica Financiera I', 1, 3, 3, 'LCM0202', ninguno).
materia(lcm, 'LCM0107', 'Historia e Identidad Nacional', 1, 3, 3, ninguno, ninguno).
materia(lcm, 'LCM0402', 'Contabilidad II', 1, 3, 3, 'LCM0401', ninguno).
materia(lcm, 'LCM0108', 'Ingles III', 1, 3, 3, ninguno, 'LCM0106').

% =====================================================
% ANO II
% =====================================================

% --- Cuatrimestre IV ---
materia(lcm, 'LCM0502', 'Mercadeo II', 2, 4, 3, 'LCM0501', ninguno).
materia(lcm, 'LCM0204', 'Matematica Financiera II', 2, 4, 3, 'LCM0203', ninguno).
materia(lcm, 'LCM0205', 'Estadistica Descriptiva para la Administracion', 2, 4, 3, 'LCM0202', ninguno).
materia(lcm, 'LCM0601', 'Etica Financiera y Responsabilidad Social Corporativa en Finanzas', 2, 4, 3, ninguno, ninguno).
materia(lcm, 'LCM0109', 'Ingles IV', 2, 4, 3, ninguno, 'LCM0108').

% --- Cuatrimestre V ---
materia(lcm, 'LCM1101', 'Fundamentos de Comunicacion Grafica', 2, 5, 2, ninguno, ninguno).
materia(lcm, 'LCM0206', 'Estadistica Inferencial para la Administracion', 2, 5, 3, 'LCM0205', ninguno).
materia(lcm, 'LCM0801', 'Microeconomia', 2, 5, 3, ninguno, ninguno).
materia(lcm, 'LCM0207', 'Simulacion y Modelado de Decisiones', 2, 5, 3, 'LCM0202', ninguno).
materia(lcm, 'LCM0403', 'Contabilidad de Costos', 2, 5, 3, 'LCM0402', ninguno).

% --- Cuatrimestre VI ---
materia(lcm, 'LCM0602', 'Gestion del Talento Humano', 2, 6, 3, 'LCM0301', ninguno).
materia(lcm, 'LCM0802', 'Macroeconomia', 2, 6, 3, 'LCM0801', ninguno).
materia(lcm, 'LCM0901', 'Derecho Mercantil', 2, 6, 3, ninguno, ninguno).
materia(lcm, 'LCM0503', 'Politica de Costos y Precios', 2, 6, 3, 'LCM0403', ninguno).
materia(lcm, 'LCM0404', 'Administracion Financiera', 2, 6, 3, ninguno, 'LCM0402').

% =====================================================
% ANO III
% =====================================================

% --- Cuatrimestre VII ---
materia(lcm, 'LCM0702', 'Fundamentos de Base de Datos', 3, 7, 3, ninguno, ninguno).
materia(lcm, 'LCM0902', 'Derecho Laboral', 3, 7, 3, ninguno, ninguno).
materia(lcm, 'LCM0302', 'Planificacion Estrategica', 3, 7, 2, ninguno, 'LCM0301').
materia(lcm, 'LCM0405', 'Finanzas Especiales', 3, 7, 3, 'LCM0404', ninguno).
materia(lcm, 'LCM1102', 'Diseno Grafico Publicitario', 3, 7, 3, 'LCM1101', ninguno).

% --- Cuatrimestre VIII ---
materia(lcm, 'LCM0504', 'Direccion de Ventas', 3, 8, 3, ninguno, 'LCM0503').
materia(lcm, 'LCM0505', 'Investigacion de Mercados', 3, 8, 3, 'LCM0502', ninguno).
materia(lcm, 'LCM0406', 'Finanzas Corporativas', 3, 8, 3, 'LCM0405', ninguno).
materia(lcm, 'LCM0303', 'Direccion Estrategica', 3, 8, 3, 'LCM0302', ninguno).
materia(lcm, 'LCM1001', 'Metodologia de la Investigacion', 3, 8, 3, ninguno, 'LCM0206').

% --- Cuatrimestre IX ---
materia(lcm, 'LCM0506', 'Gestion Estrategica de la Cadena de Suministro', 3, 9, 3, ninguno, 'LCM0303').
materia(lcm, 'LCM0507', 'Gestion Aduanera', 3, 9, 3, ninguno, ninguno).
materia(lcm, 'LCM0304', 'Teoria de la Decision', 3, 9, 3, 'LCM0303', ninguno).
materia(lcm, 'LCM0903', 'Derecho Tributario y Aduanero', 3, 9, 3, ninguno, 'LCM0901').
materia(lcm, 'LCM1103', 'Diseno y Gestion Web I', 3, 9, 3, ninguno, 'LCM1101').

% =====================================================
% ANO IV
% =====================================================

% --- Cuatrimestre X ---
materia(lcm, 'LCM0508', 'Comportamiento del Consumidor', 4, 10, 3, ninguno, 'LCM0505').
materia(lcm, 'LCM1002', 'Marca Personal y Emprendimiento', 4, 10, 2, 'LCM0505', ninguno).
materia(lcm, 'LCM1003', 'Formulacion y Evaluacion de Proyectos', 4, 10, 3, ninguno, 'LCM0505').
materia(lcm, 'LCM0509', 'Gestion Estrategica Publicitaria', 4, 10, 3, 'LCM0303', ninguno).
materia(lcm, 'LCM0510', 'Mercadotecnia Internacional', 4, 10, 3, 'LCM0502', ninguno).

% --- Cuatrimestre XI ---
materia(lcm, 'LCM0110', 'Iglesia Laicado y Ecumenismo', 4, 11, 2, ninguno, 'LCM0101').
materia(lcm, 'LCM1004', 'Innovacion de Modelos de Negocios y Gestion de Empresas', 4, 11, 3, ninguno, 'LCM1002').
materia(lcm, 'LCM1104', 'Diseno y Gestion Web II', 4, 11, 3, 'LCM1103', ninguno).
materia(lcm, 'LCM1005', 'Gerencia de Proyectos', 4, 11, 3, 'LCM1003', ninguno).
materia(lcm, 'LCM0511', 'Comercio Internacional', 4, 11, 3, ninguno, 'LCM0903').

% --- Cuatrimestre XII ---
materia(lcm, 'LCM1006', 'Proyecto de Graduacion I', 4, 12, 3, 'LCM1003', ninguno).
materia(lcm, 'LCM0512', 'Gerencia de Mercadeo', 4, 12, 3, 'LCM0509', ninguno).
materia(lcm, 'LCM0513', 'Comercio Electronico', 4, 12, 3, 'LCM1104', ninguno).
materia(lcm, 'LCM0514', 'Marketing Digital', 4, 12, 2, 'LCM0509', ninguno).

% =====================================================
% ANO V
% =====================================================

% --- Cuatrimestre XIII ---
materia(lcm, 'LCM1007', 'Proyecto de Graduacion II', 5, 13, 3, 'LCM1006', ninguno).
materia(lcm, 'LCMPFP', 'Practicas de Formacion Profesional', 5, 13, 10, ninguno, ninguno).
