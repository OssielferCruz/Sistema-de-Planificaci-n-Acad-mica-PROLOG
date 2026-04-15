# Propuesta de Proyecto: Sistema Experto de Planificación Académica (ICE 2026)

## 1. Descripción General del Proyecto
El **Sistema Experto de Planificación Académica PROLOG** es una aplicación de software inteligente desarrollada íntegramente en el paradigma de programación lógica mediante **SWI-Prolog**. Está diseñado para asistir a los estudiantes de la carrera ICE (Plan 2026) en la gestión, análisis y simulación de su progreso académico.

A través de un motor de inferencia basado en reglas y una base de conocimientos estructurada con el pensum de la carrera, el sistema es capaz de evaluar prerrequisitos, identificar cuellos de botella mediante análisis de rutas críticas, y sugerir estrategias de matrícula a los estudiantes, todo esto encapsulado en una **Interfaz Gráfica de Usuario (GUI)** amigable y estable construida con la biblioteca **XPCE**.

## 2. Arquitectura del Sistema
El proyecto sigue una arquitectura modular en tres componentes principales:

1. **Base de Conocimientos (`plan_ice_2026.pl`):** Contiene la malla curricular completa (14 cuatrimestres / 5 años). Cada materia está modelada como un hecho detallando su código, nombre, cuatrimestre, créditos, prerrequisitos estrictos y precedentes sugeridos.
2. **Motor de Inferencia (`motor_inferencia.pl`):** Es el "cerebro" del sistema. Utiliza recursividad, manipulación de listas y análisis de grafos estructurados en Prolog para ejecutar el razonamiento lógico.
3. **Interfaz Principal (`sistema_principal.pl`):** Es una sólida GUI desarrollada usando el entorno de ventanas XPCE original de SWI-Prolog, diseñada a dos columnas para mostrar el catálogo y el expediente en simultáneo, controlando acciones con paneles interactivos que no se superponen (dialog_group).

## 3. Funcionalidades y Capacidades Principales

### 3.1. Gestión del Expediente Académico
* **Marcaje Interactivo:** Permite añadir o quitar materias aprobadas al expediente en tiempo real con un par de clics.
* **Persistencia de Sesión:** Posibilidad de guardar (`.txt` / `.pl`) el expediente actual y cargarlo posteriormente para retomar la planificación donde se dejó.
* **Cálculo de Progreso:** Calcula dinámicamente el avance respecto a la cantidad total de créditos del plan de estudios.

### 3.2. Motor de Validaciones y Simulación de Matrícula
* **Verificación de Requisitos:** Evalúa de manera automática si el alumno es elegible para matricular una materia analizando tanto prerrequisitos como precedentes faltantes.
* **Simulador de Matrícula:** Muestra exactamente cuáles materias están completamente habilitadas para cursar en el escenario actual y cuáles continúan bloqueadas.

### 3.3. Algoritmos de Ruta Crítica y Cuellos de Botella
* **Ruta Crítica hacia Atrás (Dependencias):** Determina qué conjunto completo de materias deben aprobarse primero para poder alcanzar una meta a futuro, uniendo las ramas de un árbol de dependencias.
* **Ruta Crítica hacia Adelante (Desbloqueos):** Revela con qué materias el estudiante "abre puertas" a futuro. Ideal para decisiones estratégicas.
* **Estrategia Inteligente de Recuperación:** En caso de que un estudiante pierda el rimo normal, el sistema evalúa a cuántas clases bloquea esa materia. Si la materia arrastra a 2 o más asignaturas en el futuro, es calificada con **Prioridad Alta (Cuello de Botella)**, sugiriéndole priorizarla y proponiendo alternativas de avance viables con los créditos restantes.

## 4. Tecnologías Empleadas
* **Lenguaje:** SWI-Prolog
* **Interfaz de Usuario:** XPCE (Prolog's Native GUI Framework)
* **Paradigmas:** Programación Lógica, Base de Conocimientos Estructurada, Inferencia Declarativa.

## 5. Conclusión y Valor Aportado
El presente desarrollo abandona las plantillas estáticas convencionales, integrando un verdadero sistema analítico con **procesamiento lógico inteligente**. Esto no solo evita errores a la hora de matricular, sino que empodera al estudiante entregándole visibilidad absoluta sobre las repercusiones a largo plazo (ruta crítica) de priorizar o posponer materias, optimizando así los tiempos de graduación.
