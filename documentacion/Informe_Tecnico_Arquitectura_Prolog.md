# Informe Tecnico Detallado del Sistema (PROLOG + XPCE)

## 1. Alcance del informe
Este documento explica la construccion tecnica interna del sistema, enfocandose en como esta implementado y como se conectan sus componentes en PROLOG.

Queda excluida la parte web, por solicitud.

## 2. Metodo de estructuracion usado en el proyecto
El sistema sigue una **arquitectura modular en capas** (layered modular architecture) sobre programacion logica declarativa:

1. Capa de conocimiento (hechos): planes de estudio en archivos `planes/*.pl`.
2. Capa de inferencia (reglas): `motor_inferencia.pl`.
3. Capa de presentacion y control (GUI): `sistema_principal.pl` con XPCE.

A nivel de paradigma, tambien es un **sistema basado en conocimiento y reglas** (knowledge-based rule system), donde:

- Los hechos `materia/8` son la base de datos declarativa.
- Los predicados del motor son reglas que consultan, transforman y razonan sobre esos hechos.
- La GUI no contiene logica academica compleja: delega en el motor y solo administra estado interactivo y eventos de interfaz.

## 3. Conexion entre los 3 bloques de codigo

### 3.1 Conexion de compilacion/carga
- `sistema_principal.pl` carga `motor_inferencia.pl` con `ensure_loaded/1`.
- `motor_inferencia.pl` carga los planes (`planes/plan_*.pl`) con `ensure_loaded/1`.
- Los archivos de planes definen hechos `materia/8` visibles para el motor y, por extension, para la GUI.

Esto crea una cadena:

`GUI XPCE -> Motor de inferencia -> Base de conocimiento`

### 3.2 Conexion semantica
El punto de acoplamiento principal entre modulos es el predicado `materia/8`.

- El motor depende de `materia/8` para verificar requisitos, calcular rutas y creditos.
- La GUI usa funciones del motor, y tambien consulta `materia/8` para renderizar textos (catalogo, expediente, nombres de materias).

### 3.3 Tipo de acoplamiento
- Acoplamiento de datos declarativos por predicado compartido (`materia/8`).
- Acoplamiento funcional por invocacion de predicados publicos del motor desde handlers de GUI.
- Bajo acoplamiento visual-logico: XPCE no implementa reglas de negocio profundas.

## 4. Archivo 1: Base de conocimiento (`planes/plan_*.pl`)

## 4.1 Rol tecnico
Representa el modelo academico como hechos inmutables de dominio.

## 4.2 Estructura de cada hecho
Formato:

`materia(Carrera, Codigo, Nombre, Ano, Periodo, Creditos, Prerrequisito, Precedente).`

Descripcion tecnica de campos:

- `Carrera`: atom de alcance de plan (ej. `ice`, `iel`, `ims`).
- `Codigo`: identificador de asignatura.
- `Nombre`: etiqueta humana.
- `Ano` y `Periodo`: metadata temporal curricular.
- `Creditos`: magnitud usada en acumuladores numericos.
- `Prerrequisito`: dependencia estricta principal.
- `Precedente`: dependencia secundaria/alternativa que tambien participa en validacion.

## 4.3 Directivas importantes
Cada archivo de plan declara:

- `:- discontiguous materia/8.`
- `:- multifile materia/8.`

Significado tecnico:

- `discontiguous`: permite definir `materia/8` en bloques no contiguos sin warning.
- `multifile`: habilita que el mismo predicado este distribuido en multiples archivos.

Gracias a esto, todos los planes coexisten en un mismo espacio logico de `materia/8` sin conflictos de definicion.

## 4.4 Implicacion de diseno
La base no es una tabla en runtime externo; es codigo fuente declarativo compilado por SWI-Prolog. La consulta es nativa al motor logico (unificacion + backtracking).

## 5. Archivo 2: Motor de inferencia (`motor_inferencia.pl`)

## 5.1 Rol tecnico
Es la capa de reglas puras del dominio academico.

## 5.2 Bloque I/O de expediente
Predicados:

- `guardar_expediente/2`
- `cargar_expediente/2`

Implementacion tecnica:

- Persistencia con `open/3`, `writeq/2`, `read/2`, `close/1`.
- El expediente se serializa como termino Prolog, no como JSON ni CSV.
- Existe clausula de tolerancia: si archivo no existe, devuelve `[]`.

Esto reduce friccion de primer uso y evita excepcion por archivo faltante.

## 5.3 Validacion de matricula
Predicados clave:

- `cumple_requisito/2`
- `requisitos_pendientes/4`
- `habilitado_para_matricular/3`
- `materias_habilitadas/3`
- `materias_bloqueadas/3`

Mecanica:

1. Extrae `Prerreq` y `Preced` de `materia/8`.
2. Usa `findall/3` para recolectar faltantes no aprobados.
3. Normaliza con `sort/2` para quitar duplicados y ordenar.

Patron logico:

- Filtro declarativo por pertenencia (`member/2`) y negacion por fallo (`\+`).
- Sin estructuras mutables: todo se deriva por consulta.

## 5.4 Rutas criticas (recursion + grafo implicito)

### Ruta hacia atras
Predicados:

- `ruta_critica_atras/3`
- `ruta_critica_atras_aux/3`

Tecnica:

- DFS recursivo sobre dependencias (`Prerreq`, `Preced`).
- Caso base en `ninguno`.
- Luego aplica `eliminar_duplicados_preservando_orden/2` para mantener secuencia estable sin repetidos.

### Ruta hacia adelante
Predicados:

- `desbloqueos_inmediatos/3`
- `ruta_critica_adelante/3`
- `ruta_critica_adelante_aux/4`

Tecnica:

- Descubre vecinos del grafo inverso: materias que tienen al codigo actual como requisito o precedente.
- Expande frontera con lista de pendientes y lista de visitados.
- Evita ciclos/repetidos usando `subtract/3` entre nuevos y visitados.

Esta tecnica equivale a una exploracion por ondas (estilo BFS simplificado con cola representada en lista).

## 5.5 Calculo de creditos y progreso
Predicados:

- `calcular_creditos/3` (recursion estructural)
- `total_creditos_carrera/2` (`findall` + `sum_list`)
- `progreso_creditos/5`

Detalles:

- `calcular_creditos/3` suma creditos del expediente actual, sujeto a la carrera activa.
- El total de carrera se deriva on-demand de la base declarativa, sin constantes hardcodeadas.

## 5.6 Recomendador de recuperacion
Predicados:

- `peso_bloqueo/3`
- `recomendar_recuperacion/3`
- `materias_adelantables/4`

Logica:

- Mide impacto de una materia por cantidad de desbloqueos futuros.
- Clasifica prioridad alta si `Peso >= 2`.
- Usa corte (`!`) para confirmar la primera regla que cumple umbral y evitar reevaluacion.

## 5.7 Complejidad conceptual
Aunque Prolog abstrae estructuras, el motor modela explicitamente:

- filtrado de conjuntos,
- busqueda en grafo de dependencias,
- agregacion numerica,
- evaluacion de elegibilidad basada en restricciones.

## 6. Archivo 3: Interfaz y orquestacion (`sistema_principal.pl`)

## 6.1 Rol tecnico
Capa de presentacion + controlador de flujo de usuario sobre XPCE.

No reemplaza al motor: orquesta eventos, estado interactivo y renderizado.

## 6.2 Estado de aplicacion en memoria
Predicados dinamicos:

- `expediente_actual/1`
- `carrera_actual/1`
- `filtro_catalogo/1`
- `archivo_sesion_actual/1`

Patron utilizado: estado global controlado por `retractall/1` + `asserta/1`.

Esto implementa un store simple dentro del interprete Prolog.

## 6.3 Bootstrap de UI
Predicado central: `iniciar_sistema/0`.

Tecnica usada:

- Destruccion defensiva de objetos XPCE previos (`object/1` + `destroy/free`).
- Construccion declarativa de widgets (`dialog`, `browser`, `editor`, `button`, `menu`).
- Composicion por grupos (`dialog_group`) para layout estable y sin solapamiento.

## 6.4 Render de catalogo y expediente
Predicados:

- `llenar_catalogo_materias/0`
- `actualizar_browser_expediente/0`

Pipeline:

1. Lee estado actual (carrera + filtro + expediente).
2. Recorre hechos `materia/8` con `forall/2`.
3. Formatea texto visible con `format/3`.
4. Inserta items con `dict_item` y clave de codigo.

## 6.5 Adaptadores de presentacion
Predicados:

- `fmt_materias/3`
- `fmt_bloqueadas/3`
- `fmt_codigos_con_nombre/3`
- `etiqueta_materia/3`

Funcion tecnica:

- Traducen estructuras logicas (listas de codigos y pares) a texto explicativo.
- Separan claramente capa de calculo (motor) de capa de representacion (GUI).

## 6.6 Handlers de eventos (controlador)
Ejemplos:

- `acc_verificar/0`
- `acc_ruta_critica/0`
- `acc_simular_matricula/0`
- `acc_recomendar_recuperacion/0`
- `acc_marcar_aprobada/0`
- `acc_quitar_aprobada/0`
- `acc_ver_progreso/0`

Patron interno repetido:

1. Obtener seleccion de UI (`obtener_codigo_seleccionado/2`).
2. Leer estado dinamico.
3. Delegar computo al motor.
4. Formatear resultado para humano.
5. Refrescar widgets/estado si aplica.

## 6.7 Persistencia de sesion en GUI
Predicados:

- `acc_guardar/0`
- `acc_guardar_confirmar/1`
- `acc_cargar/0`
- `acc_cargar_confirmar/0`
- `guardar_sesion_xpce/3`
- `acc_nueva_sesion/0`

Diseno tecnico destacado:

- Formato de sesion: `sesion_xpce(Carrera, Expediente).`
- Validacion de compatibilidad por carrera al cargar.
- Rechazo de formato legado sin carrera.
- Sobrescritura automatica cuando existe `archivo_sesion_actual/1`.
- Reinicio limpio con `acc_nueva_sesion/0` (expediente vacio + desvinculacion de archivo).

## 6.8 Flujo de carrera activa
`acc_cambiar_carrera/1` reinicia expediente, filtro y archivo de sesion, y vuelve a poblar UI.

Eso evita contaminacion cruzada de datos entre carreras.

## 6.9 Normalizacion de busqueda y codigos
- `normalizar_cadena/2` + `quitar_acento_char/2`: busqueda robusta sin depender de acentos.
- `normalizar_codigo/2`: compatibiliza codigos numericos viejos con formato atomico estandar.

## 7. Modelo de ejecucion integral (sin web)

## 7.1 Secuencia de arranque
1. SWI-Prolog consulta `sistema_principal.pl`.
2. Se carga `motor_inferencia.pl`.
3. El motor carga todos los planes en `planes/`.
4. `iniciar_sistema/0` levanta XPCE y construye estado inicial.

## 7.2 Secuencia de consulta tipica (verificar requisitos)
1. Usuario selecciona materia en browser.
2. Handler `acc_verificar/0` toma codigo y expediente.
3. Invoca `requisitos_pendientes/4` en motor.
4. Motor consulta `materia/8` y calcula faltantes.
5. GUI convierte lista tecnica en mensaje legible y lo presenta.

## 7.3 Naturaleza del procesamiento
- La base es declarativa.
- El motor es funcionalmente puro (salvo I/O).
- La GUI concentra mutabilidad de estado de sesion.

## 8. Tecnicas de Prolog aplicadas en el proyecto

1. **Unificacion** para casar patrones de hechos `materia/8`.
2. **Backtracking controlado** para explorar soluciones.
3. **Recursion estructural** en rutas y sumatorias.
4. **Negacion por fallo (`\+`)** para reglas de exclusiones.
5. **Corte (`!`)** para control de determinismo en casos puntuales.
6. **Predicados dinamicos** como estado global de runtime.
7. **Serializacion de terminos Prolog** para persistencia natural.

## 9. Conclusiones tecnicas para exposicion

1. El sistema esta implementado como arquitectura en capas con separacion real de responsabilidades.
2. El nucleo academico esta en reglas Prolog reutilizables e independientes de interfaz.
3. La interfaz XPCE opera como controlador de eventos y presentacion, no como motor de reglas.
4. La base de conocimiento usa un modelo multifile/discontiguous que escala a multiples carreras.
5. Las decisiones recientes de sesion (validacion por carrera, sobrescritura contextual y nueva sesion) fortalecen integridad y usabilidad sin romper la arquitectura.

## 10. Glosario corto para defensa oral

- **Sistema basado en conocimiento**: software que razona sobre hechos y reglas de dominio.
- **Inferencia declarativa**: resolver consultas por relaciones logicas, no por instrucciones imperativas paso a paso.
- **Acoplamiento por predicado compartido**: modulos distintos cooperan consultando el mismo predicado (`materia/8`).
- **Multifile/discontiguous**: tecnica de Prolog para distribuir un predicado en multiples archivos.
- **Controlador XPCE**: capa que traduce acciones de UI a llamadas de logica de negocio.
