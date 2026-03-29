% Base de Conocimientos: Plan de Estudios ICE 2026
% Formato: materia(Carrera, Codigo, Nombre, Año, Cuatrimestre, Creditos, Prerrequisito, Precedente).
% Utilizamos 'ninguno' cuando no existe dependencia.

% --- AÑO I ---
% Cuatrimestre I
materia(ice, '0401', 'Ética y Lasallismo', 1, 1, 2, ninguno, ninguno).
materia(ice, '0901', 'Introducción a la Ingeniería', 1, 1, 4, ninguno, ninguno).
materia(ice, '0101', 'Matemática I', 1, 1, 3, ninguno, ninguno).
materia(ice, '0701', 'Ofimática Aplicada', 1, 1, 3, ninguno, ninguno).
materia(ice, '0402', 'Identidad Nacional y Orgullo Patrio', 1, 1, 4, ninguno, ninguno).

% Cuatrimestre II
materia(ice, '0902', 'Dibujo Técnico Asistido', 1, 2, 3, ninguno, '0901').
materia(ice, '0403', 'Inglés I', 1, 2, 2, ninguno, ninguno).
materia(ice, '0102', 'Matemática II', 1, 2, 3, '0101', ninguno).
materia(ice, '0201', 'Física', 1, 2, 4, ninguno, '0101').
materia(ice, '0404', 'Redacción Técnica', 1, 2, 3, ninguno, ninguno).

% Cuatrimestre III
materia(ice, '0405', 'Inglés II', 1, 3, 2, ninguno, '0403').
materia(ice, '0702', 'Introducción a la Programación', 1, 3, 3, ninguno, ninguno).
materia(ice, '0103', 'Matemática III', 1, 3, 3, '0102', ninguno).
materia(ice, '0203', 'Química General', 1, 3, 3, ninguno, ninguno).
materia(ice, '0406', 'Historia e Identidad Nacional', 1, 3, 3, ninguno, ninguno).

% --- AÑO II ---
% Cuatrimestre IV
materia(ice, '0301', 'Circuitos Eléctricos', 2, 4, 4, ninguno, '0103').
materia(ice, '0104', 'Matemática IV', 2, 4, 3, '0103', ninguno).
materia(ice, '0703', 'Lenguaje de Programación I', 2, 4, 3, ninguno, '0702').
materia(ice, '0105', 'Probabilidad y Estadística', 2, 4, 3, ninguno, '0103').
materia(ice, '0204', 'Estática', 2, 4, 3, ninguno, '0201').

% Cuatrimestre V
materia(ice, '0106', 'Análisis Numérico', 2, 5, 3, ninguno, '0703').
materia(ice, '0205', 'Dinámica', 2, 5, 3, '0204', ninguno).
materia(ice, '0107', 'Investigación de Operaciones I', 2, 5, 3, ninguno, '0105').
materia(ice, '0705', 'Lenguaje de Programación II', 2, 5, 3, '0703', ninguno).
materia(ice, '0407', 'Inglés III', 2, 5, 2, ninguno, '0405').

% Cuatrimestre VI
materia(ice, '0501', 'Electrónica Analógica', 2, 6, 4, '0301', ninguno).
materia(ice, '0706', 'Sistemas Operativos I', 2, 6, 3, ninguno, '0705').
materia(ice, '0707', 'Base de datos y Programación Orientada a Objetos', 2, 6, 3, '0705', ninguno).
materia(ice, '0408', 'Iglesia, Laicado y Ecumenismo', 2, 6, 2, ninguno, '0401').
materia(ice, '0708', 'Estructura de Datos y Organización de Archivos', 2, 6, 4, ninguno, '0705').

% --- AÑO III ---
% Cuatrimestre VII
materia(ice, '0502', 'Electrónica Digital I', 3, 7, 3, ninguno, '0501').
materia(ice, '0503', 'Mando Electromecánico', 3, 7, 3, '0301', ninguno).
materia(ice, '0209', 'Ingeniería Ambiental I', 3, 7, 2, ninguno, '0203').
materia(ice, '0504', 'Electrónica Industrial', 3, 7, 4, ninguno, '0501').
materia(ice, '0709', 'Sistemas Operativos II', 3, 7, 3, '0706', ninguno).

% Cuatrimestre VIII
materia(ice, '0505', 'Instrumentación y Control', 3, 8, 3, '0504', ninguno).
materia(ice, '0601', 'Metodología de la Investigación', 3, 8, 2, '0404', ninguno).
materia(ice, '1001', 'Teoría Computacional', 3, 8, 2, ninguno, '0708').
materia(ice, '0710', 'Arquitectura de Computadoras', 3, 8, 3, ninguno, '0706').
materia(ice, '0711', 'Diseño Web', 3, 8, 3, ninguno, '0707').

% Cuatrimestre IX
materia(ice, '0712', 'Tecnología de Redes', 3, 9, 3, '0710', ninguno).
materia(ice, '0507', 'Sistemas de Control', 3, 9, 3, '0505', ninguno).
materia(ice, '0508', 'Control Lógico Programable', 3, 9, 3, ninguno, '0503').
materia(ice, '0109', 'Modelos de Simulación', 3, 9, 3, '0107', ninguno).
materia(ice, '0802', 'Principios de Administración', 3, 9, 3, ninguno, ninguno).

% --- AÑO IV ---
% Cuatrimestre X
materia(ice, '0713', 'Medios y Protocolos de Comunicación', 4, 10, 3, '0712', ninguno).
materia(ice, '1002', 'Programación Lógica', 4, 10, 3, '1001', ninguno).
materia(ice, '0714', 'Programación Web', 4, 10, 3, '0711', ninguno).
materia(ice, '0715', 'Mantenimiento Preventivo de PC', 4, 10, 3, ninguno, '0710').
materia(ice, '0510', 'Robótica General', 4, 10, 3, ninguno, '0508').

% Cuatrimestre XI
materia(ice, '0806', 'Administración Financiera I', 4, 11, 3, '0802', ninguno).
materia(ice, '0717', 'Ingeniería de Software', 4, 11, 3, ninguno, '0714').
materia(ice, '0718', 'Administración de Centros de Cómputos', 4, 11, 2, ninguno, ninguno).
materia(ice, '0719', 'Taller de Conectividad', 4, 11, 3, '0713', ninguno).

% Cuatrimestre XII
materia(ice, '1003', 'Inteligencia Artificial', 4, 12, 3, ninguno, '1002').
materia(ice, '0720', 'Tecnología de Redes Globales', 4, 12, 3, '0719', ninguno).
materia(ice, '0409', 'Sociología General', 4, 12, 2, ninguno, ninguno).
materia(ice, '0602', 'Formulación y Evaluación de Proyectos', 4, 12, 3, ninguno, '0806').

% --- AÑO V ---
% Cuatrimestre XIII
materia(ice, '0721', 'Legislación de las TIC', 5, 13, 2, ninguno, '0718').
materia(ice, '1004', 'Temas Selectos de Cibernética', 5, 13, 4, ninguno, '1003').
materia(ice, '0604', 'Proyecto de Graduación I', 5, 13, 3, '0601', ninguno).
materia(ice, '0722', 'Seguridad y Auditoria de Sistemas', 5, 13, 2, ninguno, '0720').

% Cuatrimestre XIV
materia(ice, '0605', 'Proyecto de Graduación II', 5, 14, 3, '0604', ninguno).
materia(ice, 'ICE-PFP', 'Prácticas de Formación Profesional', 5, 14, 10, ninguno, ninguno).
