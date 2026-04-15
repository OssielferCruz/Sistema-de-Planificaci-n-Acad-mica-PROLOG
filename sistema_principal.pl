/*
 * Sistema Experto de Planificacion Academica - ICE 2026
 * Interfaz Grafica v4.0 - FINAL ESTABLE
 *
 * ARQUITECTURA GARANTIZADA:
 * - Se usan ventanas agrupadas (dialog_group) estrictas que PROHIBEN el solapamiento.
 * - Fuentes predeterminadas del sistema en los list_browser para GARANTIZAR clics perfectos.
 * - Sin cambios agresivos de fondo en listas que causaban bloqueos negros.
 */

:- use_module(library(pce)).
:- ensure_loaded('motor_inferencia.pl').

:- dynamic expediente_actual/1.
:- dynamic carrera_actual/1.
:- dynamic filtro_catalogo/1.
:- dynamic archivo_sesion_actual/1.

expediente_actual([]).
carrera_actual(ice).
filtro_catalogo('').
archivo_sesion_actual('').


% =====================================================
% BOOTSTRAP DE INTERFAZ
% =====================================================

iniciar_sistema :-
    % Limpiar objetos previos de manera segura
    ( object(@v_main) -> send(@v_main, destroy) ; true ),
    ( object(@editor_res) -> free(@editor_res) ; true ),
    ( object(@L_estado) -> free(@L_estado) ; true ),
    ( object(@cat_browser) -> free(@cat_browser) ; true ),
    ( object(@exp_browser) -> free(@exp_browser) ; true ),
    ( object(@lbl_titulo) -> free(@lbl_titulo) ; true ),

    % Crear ventana principal simple
    new(@v_main, dialog('Planificador Academico ICE 2026')),
    send(@v_main, size, size(1100, 720)),
    
    % Titulo principal (dinamico segun carrera)
    nombre_carrera_lbl(TituloTxt),
    new(@lbl_titulo, label(titulo, TituloTxt)),
    send(@lbl_titulo, font, font(helvetica, bold, 22)),
    send(@lbl_titulo, colour, colour(dark_green)),
    send(@v_main, append, @lbl_titulo),

    % ===============================
    % FILA 1: SELECTOR DE CARRERA + BUSCADOR
    % ===============================
    new(GSearch, dialog_group('')), send(GSearch, pen, 0),

    % Selector de carrera
    new(MenuCarrera, menu('Carrera:', cycle)),
    send(MenuCarrera, append, menu_item(ice, message(@prolog, acc_cambiar_carrera, ice), 'Ing. Cibernetica (ICE)')),
    send(MenuCarrera, append, menu_item(igi, message(@prolog, acc_cambiar_carrera, igi), 'Ing. Gestion Ind. (IGI)')),
    send(MenuCarrera, append, menu_item(ime, message(@prolog, acc_cambiar_carrera, ime), 'Ing. Mecanica (IME)')),
    send(MenuCarrera, append, menu_item(ims, message(@prolog, acc_cambiar_carrera, ims), 'Ing. Mecatronica (IMS)')),
    send(MenuCarrera, append, menu_item(iem, message(@prolog, acc_cambiar_carrera, iem), 'Ing. Electromedica (IEM)')),
    send(MenuCarrera, append, menu_item(laf, message(@prolog, acc_cambiar_carrera, laf), 'Lic. Admin. Finanzas (LAF)')),
    send(MenuCarrera, append, menu_item(lcm, message(@prolog, acc_cambiar_carrera, lcm), 'Lic. Com. Mercadeo (LCM)')),
    send(MenuCarrera, append, menu_item(iel, message(@prolog, acc_cambiar_carrera, iel), 'Ing. Electrica (IEL)')),
    carrera_actual(CarAct),
    send(MenuCarrera, selection, CarAct),
    send(GSearch, append, MenuCarrera),

    % Buscador
    new(@txt_buscar, text_item('Buscar Curso:', '')),
    send(@txt_buscar, message, message(@prolog, acc_buscar_catalogo, @receiver?selection)),
    
    % Fija explicitamente colores fuertes para que resalte la letra
    send(@txt_buscar, colour, colour(black)),
    send(@txt_buscar, value_font, font(helvetica, bold, 12)),
    
    send(GSearch, append, @txt_buscar, right),
    send(GSearch, append, button('Limpiar Busqueda', message(@prolog, acc_buscar_limpiar)), right),
    send(@v_main, append, GSearch),

    % ===============================
    % FILA 2: BIFURCACION DE COLUMNAS
    % ===============================
    new(GLeft, dialog_group('')), send(GLeft, pen, 0),
    new(GRight, dialog_group('')), send(GRight, pen, 0),

    % --- COLUMNA IZQUIERDA (Cursos y Resultados) ---
    ( object(@cat_browser) -> free(@cat_browser) ; true ),
    new(@cat_browser, browser('Cursos')),
    send(@cat_browser, size, size(50, 15)),
    send(@cat_browser, background, colour(white)),
    send(@cat_browser, style, estilo_negro, style(colour:=colour(black))),
    send(GLeft, append, @cat_browser),

    % Espaciador invisible para separar Resultados de Cursos
    send(GLeft, append, label(espaciador, ''), below),

    new(GRes, dialog_group('Resultados Herramientas')),
    new(@editor_res, editor),
    send(@editor_res, size, size(55, 12)),
    send(@editor_res, editable, @off),
    send(@editor_res, background, colour(white)),
    send(@editor_res, colour, colour(black)),
    send(@editor_res, font, font(courier, roman, 12)),
    send(GRes, append, @editor_res),
    send(GLeft, append, GRes, below),

    % --- COLUMNA DERECHA (Expediente y Botones) ---
    ( object(@exp_browser) -> free(@exp_browser) ; true ),
    new(@exp_browser, browser('Mi expediente')),
    send(@exp_browser, size, size(50, 15)),
    send(@exp_browser, background, colour(white)),
    send(@exp_browser, style, estilo_negro, style(colour:=colour(black))),
    send(GRight, append, @exp_browser),

    % Espaciador para bajar los botones
    send(GRight, append, label(esp_btn, ''), below),

    new(GBtn, dialog_group(' A C C I O N E S ', box)),
    
    % Creacion de botones
    new(B1, button('Verificar req.', message(@prolog, acc_verificar))),
    new(B2, button('Ruta critica', message(@prolog, acc_ruta_critica))),
    new(B3, button('Simulacion', message(@prolog, acc_simular_matricula))),
    new(B4, button('Recuperacion', message(@prolog, acc_recomendar_recuperacion))),
    new(B5, button('Tu progreso', message(@prolog, acc_ver_progreso))),
    
    new(B6, button('Marcar aprobada', message(@prolog, acc_marcar_aprobada))),
    new(B7, button('Quitar aprobada', message(@prolog, acc_quitar_aprobada))),
    new(B8, button('Guardar sesion', message(@prolog, acc_guardar))),
    new(B9, button('Cargar sesion', message(@prolog, acc_cargar))),
    new(B10, button('Nueva sesion', message(@prolog, acc_nueva_sesion))),

    % Estilizar botones
    send_list([B1,B2,B3,B4,B5,B6,B7,B8,B9,B10], font, font(helvetica, bold, 10)),

    % Ensamble de la Fila 1 (Horizontal)
    send(GBtn, append, B1),
    send(GBtn, append, B2, right),
    send(GBtn, append, B3, right),
    send(GBtn, append, B4, right),
    send(GBtn, append, B5, right),

    % Ensamble de la Fila 2 (Horizontal)
    send(GBtn, append, B6, below),
    send(GBtn, append, B7, right),
    send(GBtn, append, B8, right),
    send(GBtn, append, B9, right),
    send(GBtn, append, B10, right),

    send(GRight, append, GBtn, below),

    % ===============================
    % INSTRUCCIONES (A la derecha de Botones)
    % ===============================
    new(GInst, dialog_group('Instrucciones', box)),
    send(GInst, append, label(i1, '1. Busca o selecciona cursos en la Izquierda.')),
    send(GInst, append, label(i2, '2. Usa "Marcar aprobada" para armar tu expediente.'), below),
    send(GInst, append, label(i3, '3. Usa "Simulacion" o "Ruta critica" para analizar.'), below),
    send(GInst, append, label(i4, 'Revisa la caja negra abajo a la izq. para ver resultados.'), below),
    
    send(GRight, append, GInst, right),

    % Ensamblar columnas a v_main asegurando que esten juntas horizontalmente
    new(GContent, dialog_group('')), send(GContent, pen, 0),
    send(GContent, append, GLeft),
    send(GContent, append, GRight, right),
    send(@v_main, append, GContent, below),

    % === ESTADO (BARRA INFERIOR) ===
    new(@L_estado, label(lbl_es, '')),
    send(@L_estado, font, font(helvetica, bold, 11)),
    send(@L_estado, colour, colour(dark_blue)),
    send(@v_main, append, @L_estado, below),

    % Llenar datos de arranque
    llenar_catalogo_materias,
    actualizar_browser_expediente,
    actualizar_estado_lbl,

    mostrar_resultado('El sistema se ha cargado correctamente.\nSelecciona una materia para interactuar.'),

    % Abrir de manera estandar
    send(@v_main, open).

% =====================================================
% POBLACION DE DATA
% =====================================================

llenar_catalogo_materias :-
    carrera_actual(Carrera),
    filtro_catalogo(Filtro),
    normalizar_cadena(Filtro, FiltroNorm),
    ( object(@cat_browser) -> send(@cat_browser, clear) ; true ),
    forall(
        materia(Carrera, Codigo, Nombre, _, Cuat, Cred, _, _),
        (
            normalizar_cadena(Nombre, NombreNorm),
            normalizar_cadena(Codigo, CodigoNorm),
            ( sub_atom(NombreNorm, _, _, _, FiltroNorm) ; sub_atom(CodigoNorm, _, _, _, FiltroNorm) )
            ->
            format(atom(Txt), '[~w] ~w (C~w, ~w cr)', [Codigo, Nombre, Cuat, Cred]),
            send(@cat_browser, append, dict_item(Codigo, Txt, @default, estilo_negro))
            ; true
        )
    ).

actualizar_browser_expediente :-
    carrera_actual(Carrera),
    expediente_actual(Historial),
    ( object(@exp_browser) -> send(@exp_browser, clear) ; true ),
    forall(
        member(Cod, Historial),
        (
            materia(Carrera, Cod, Nom, _, _, _, _, _),
            format(atom(Txt), '[~w] ~w', [Cod, Nom]),
            send(@exp_browser, append, dict_item(Cod, Txt, @default, estilo_negro))
        )
    ).

% =====================================================
% GLOBALES & UTILIDADES
% =====================================================

% Nombres legibles de carreras
nombre_carrera_texto(ice, 'Ing. en Cibernetica Electronica (ICE)').
nombre_carrera_texto(igi, 'Ing. en Gestion Industrial (IGI)').
nombre_carrera_texto(ime, 'Ing. en Mecanica y Energias Renovables (IME)').
nombre_carrera_texto(ims, 'Ing. en Mecatronica y Sistemas de Control (IMS)').
nombre_carrera_texto(iem, 'Ing. Electromedica (IEM)').
nombre_carrera_texto(laf, 'Lic. Administracion con Enfasis en Finanzas (LAF)').
nombre_carrera_texto(lcm, 'Lic. Comercial con Enfasis en Mercadeo (LCM)').
nombre_carrera_texto(iel, 'Ing. Electrica (IEL)').

nombre_carrera_lbl(Txt) :-
    carrera_actual(C),
    nombre_carrera_texto(C, Nombre),
    format(atom(Txt), 'Planificador Academico 2026 - ~w', [Nombre]).

% Cambiar de carrera y refrescar toda la UI
acc_cambiar_carrera(NuevaCarrera) :-
    retractall(carrera_actual(_)),
    asserta(carrera_actual(NuevaCarrera)),
    retractall(expediente_actual(_)),
    asserta(expediente_actual([])),
    retractall(filtro_catalogo(_)),
    asserta(filtro_catalogo('')),
    set_archivo_sesion_actual(''),
    ( object(@txt_buscar) -> send(@txt_buscar, selection, '') ; true ),
    llenar_catalogo_materias,
    actualizar_browser_expediente,
    actualizar_estado_lbl,
    nombre_carrera_lbl(NuevoTitulo),
    ( object(@lbl_titulo) -> send(@lbl_titulo, selection, NuevoTitulo) ; true ),
    nombre_carrera_texto(NuevaCarrera, NombreC),
    format(atom(T), 'Carrera cambiada a: ~w\nEl expediente se ha reiniciado.\nSelecciona materias del catalogo.', [NombreC]),
    mostrar_resultado(T).

mostrar_resultado(Text) :-
    ( object(@editor_res) ->
        send(@editor_res, clear),
        send(@editor_res, insert, Text),
        send(@editor_res, caret, 0)
    ; true ).

actualizar_estado_lbl :-
    expediente_actual(Lista),
    length(Lista, N),
    ( N > 0 ->
        carrera_actual(C),
        calcular_creditos(C, Lista, Cred),
        total_creditos_carrera(C, Tot),
        format(atom(M), '>>  Expediente Activo | Materias: ~w | Creditos aprobados: ~w / ~w', [N, Cred, Tot])
    ;
        M = '>>  Expediente Vacio | Selecciona materias y marca "Aprobada" para iniciar'
    ),
    ( object(@L_estado) -> send(@L_estado, selection, M) ; true ).

obtener_codigo_seleccionado(Browser, Codigo) :-
    get(Browser, selection, Sel),
    Sel \== @nil,
    get(Sel, key, KeyXPCE),
    get(KeyXPCE, value, Codigo).

etiqueta_materia(Carrera, Codigo, Etiqueta) :-
    ( materia(Carrera, Codigo, Nombre, _, _, _, _, _) ->
        format(atom(Etiqueta), '[~w] ~w', [Codigo, Nombre])
    ;
        format(atom(Etiqueta), '[~w]', [Codigo])
    ).

fmt_codigos_con_nombre(_, [], '').
fmt_codigos_con_nombre(Carrera, Codigos, Texto) :-
    findall(Etiqueta,
        ( member(Codigo, Codigos),
          etiqueta_materia(Carrera, Codigo, Etiqueta)
        ),
        Etiquetas),
    atomic_list_concat(Etiquetas, ', ', Texto).

reemplazar_expediente(L) :-
    retractall(expediente_actual(_)),
    asserta(expediente_actual(L)).

set_archivo_sesion_actual(Archivo) :-
    retractall(archivo_sesion_actual(_)),
    asserta(archivo_sesion_actual(Archivo)).

fmt_materias(_, [], '  (Ninguna)\n').
fmt_materias(Carrera, Lista, R) :-
    findall(L,
        ( member(C, Lista),
          materia(Carrera, C, N, _, Cu, Cr, _, _),
          format(atom(L), '  * [~w] ~w  (C~w, ~w cr)\n', [C, N, Cu, Cr])
        ), Lineas),
    atomic_list_concat(Lineas, '', R).

fmt_bloqueadas(_, [], '  (Ninguna)\n').
fmt_bloqueadas(Carrera, Lista, R) :-
    findall(L,
        ( member(C-Fs, Lista),
          materia(Carrera, C, N, _, _, _, _, _),
                    fmt_codigos_con_nombre(Carrera, Fs, StFs),
          format(atom(L), '  * [~w] ~w  (Te falta: ~w)\n', [C, N, StFs])
        ), Lineas),
    atomic_list_concat(Lineas, '', R).

% =====================================================
% HANDLERS DE BOTONES (Prolog atoms extraidos seguro)
% =====================================================

acc_verificar :-
    ( obtener_codigo_seleccionado(@cat_browser, Codigo) ->
        carrera_actual(Carrera),
        expediente_actual(Exp),
        ( member(Codigo, Exp) ->
            format(atom(T), '[INFO] La materia ~w ya se encuentra aprobada en tu expediente.', [Codigo]),
            mostrar_resultado(T)
        ;
            requisitos_pendientes(Carrera, Codigo, Exp, Faltantes),
            ( Faltantes == [] ->
                format(atom(T), '[OK] Puedes matricular ~w.\nCumples todos los requisitos necesarios.', [Codigo]),
                mostrar_resultado(T)
            ;
                fmt_codigos_con_nombre(Carrera, Faltantes, StrFs),
                format(atom(T), '[DENEGADO] No puedes cursar ~w aun.\n\nDebes aprobar primero: ~w', [Codigo, StrFs]),
                mostrar_resultado(T)
            )
        )
    ;
        send(@display, inform, 'Por favor selecciona una materia del CATALOGO (clic en el panel).'),
        mostrar_resultado('Error: No se selecciono ninguna materia del catalogo.')
    ).

acc_ruta_critica :-
    ( obtener_codigo_seleccionado(@cat_browser, Codigo) ->
        carrera_actual(Carrera),
        ruta_critica_atras(Carrera, Codigo, Atras),
        ruta_critica_adelante(Carrera, Codigo, Adel),
        fmt_materias(Carrera, Atras, StrA),
        fmt_materias(Carrera, Adel, StrD),
        format(atom(T),
            '*** RUTA CRITICA DE [~w] ***\n\n# DEPENDENCIAS (Hay que pasar esto antes):\n~w\n# DESBLOQUEOS (Si la pasas, se abre esto):\n~w',
            [Codigo, StrA, StrD]),
        mostrar_resultado(T)
    ;
        send(@display, inform, 'Por favor selecciona una materia del CATALOGO.'),
        mostrar_resultado('Error: No se selecciono ninguna materia del catalogo.')
    ).

acc_simular_matricula :-
    carrera_actual(Carrera),
    expediente_actual(Exp),
    materias_habilitadas(Carrera, Exp, Hab),
    materias_bloqueadas(Carrera, Exp, Bloq),
    fmt_materias(Carrera, Hab, StrH),
    fmt_bloqueadas(Carrera, Bloq, StrB),
    format(atom(T),
        '*** SIMULADOR DE MATRICULA ***\n\n# MATERIAS HABILITADAS PARA CURSAR:\n~w\n# MATERIAS AUN BLOQUEADAS:\n~w',
        [StrH, StrB]),
    mostrar_resultado(T).

acc_recomendar_recuperacion :-
    ( obtener_codigo_seleccionado(@cat_browser, Codigo) ->
        carrera_actual(Carrera),
        expediente_actual(Exp),
        recomendar_recuperacion(Carrera, Codigo, Prio),
        materias_adelantables(Carrera, Exp, [Codigo], Adel),
        fmt_materias(Carrera, Adel, StrAdel),
        format(atom(T),
            '*** RECUPERACION ESTRATEGICA: [~w] ***\n\nNivel de prioridad estrategica: ~w\n\n# MATERIAS QUE PUEDES ADELANTAR MIENTRAS TANTO:\n~w',
            [Codigo, Prio, StrAdel]),
        mostrar_resultado(T)
    ;
        send(@display, inform, 'Por favor selecciona la materia reprobada del CATALOGO primero.'),
        mostrar_resultado('Error: No se selecciono ninguna materia.')
    ).

acc_marcar_aprobada :-
    ( obtener_codigo_seleccionado(@cat_browser, Codigo) ->
        expediente_actual(Exp),
        ( member(Codigo, Exp) ->
            format(atom(T), '[INFO] La materia ~w ya habia sido aprobada.', [Codigo]),
            mostrar_resultado(T)
        ;
            append(Exp, [Codigo], Exp2),
            sort(Exp2, Exp3),
            reemplazar_expediente(Exp3),
            actualizar_browser_expediente,
            actualizar_estado_lbl,
            format(atom(T), '[EXITO] Materia ~w agregada a tu expediente. Felicidades!', [Codigo]),
            mostrar_resultado(T)
        )
    ;
        send(@display, inform, 'Por favor selecciona una materia del CATALOGO (panel izquierdo).')
    ).

acc_quitar_aprobada :-
    ( obtener_codigo_seleccionado(@exp_browser, Codigo) ->
        expediente_actual(Exp),
        ( select(Codigo, Exp, Exp2) ->
            reemplazar_expediente(Exp2),
            actualizar_browser_expediente,
            actualizar_estado_lbl,
            format(atom(T), '[EXITO] Materia ~w removida permanentemente del expediente.', [Codigo]),
            mostrar_resultado(T)
        ;
            format(atom(T), '[ERROR] La materia ~w no fue encontrada en el expediente.', [Codigo]),
            mostrar_resultado(T)
        )
    ;
        send(@display, inform, 'Por favor selecciona una materia de TU EXPEDIENTE (panel derecho).')
    ).

acc_ver_progreso :-
    carrera_actual(Carrera),
    expediente_actual(Exp),
    progreso_creditos(Carrera, Exp, Aprobados, Restantes, Total),
    length(Exp, N),
    format(atom(T),
        '*** TU PROGRESO ACADEMICO ***\n\n  - Materias que has aprobado : ~w\n  - Creditos ganados          : ~w\n  - Creditos faltantes        : ~w\n  - Total de la carrera       : ~w\n',
        [N, Aprobados, Restantes, Total]),
    mostrar_resultado(T).

acc_nueva_sesion :-
    reemplazar_expediente([]),
    set_archivo_sesion_actual(''),
    actualizar_browser_expediente,
    actualizar_estado_lbl,
    mostrar_resultado('[NUEVA SESION] Se inicio una sesion en blanco.\n\nYa puedes marcar materias aprobadas, cargar una sesion existente o guardar esta nueva sesion con otro nombre.').

acc_guardar :-
    archivo_sesion_actual(ArchivoActual),
    ArchivoActual \== '',
    !,
    carrera_actual(Carrera),
    expediente_actual(Exp),
    guardar_sesion_xpce(Carrera, Exp, ArchivoActual),
    format(atom(T), '[GUARDADO] Sesion actual sobrescrita exitosamente en:\n~w\nCarrera asociada: ~w', [ArchivoActual, Carrera]),
    mostrar_resultado(T).

acc_guardar :-
    new(D, dialog('Guardar Sesion')),
    send(D, append, label(info, 'Escribe un nombre para el archivo de sesion:')),
    send(D, append, new(TI, text_item('Nombre:', 'mi_expediente')), below),
    send(D, append, button('Aceptar', and(
        message(@prolog, acc_guardar_confirmar, TI?selection),
        message(D, destroy)
    )), below),
    send(D, append, button('Cancelar', message(D, destroy)), right),
    send(D, open_centered).

acc_guardar_confirmar(NombreRaw) :-
    get(NombreRaw, value, Nombre),
    ( Nombre == '' ->
        send(@display, inform, 'Debes escribir un nombre para el archivo.')
    ;
        carrera_actual(Carrera),
        expediente_actual(Exp),
        atom_concat(Nombre, '.sesion.pl', Archivo),
        guardar_sesion_xpce(Carrera, Exp, Archivo),
        set_archivo_sesion_actual(Archivo),
        format(atom(T), '[GUARDADO] Sesion guardada exitosamente como:\n~w\nCarrera asociada: ~w', [Archivo, Carrera]),
        mostrar_resultado(T)
    ).

acc_cargar :-
    % Buscar solo archivos de sesion de XPCE
    expand_file_name('*.sesion.pl', Sesiones),
    ( Sesiones == [] ->
        send(@display, inform, 'No se encontraron sesiones XPCE (*.sesion.pl) en esta carpeta.')
    ;
        ( object(@cargar_dlg) -> send(@cargar_dlg, destroy) ; true ),
        new(@cargar_dlg, dialog('Cargar Sesion')),
        send(@cargar_dlg, size, size(400, 350)),
        send(@cargar_dlg, append, label(info, 'Selecciona una sesion guardada:')),
        ( object(@cargar_lb) -> free(@cargar_lb) ; true ),
        new(@cargar_lb, list_browser),
        send(@cargar_lb, size, size(45, 8)),
        send(@cargar_lb, font, font(helvetica, roman, 12)),
        forall(
            member(Arch, Sesiones),
            send(@cargar_lb, append, Arch)
        ),
        send(@cargar_dlg, append, @cargar_lb, below),
        send(@cargar_dlg, append, button('Aceptar', message(@prolog, acc_cargar_confirmar)), below),
        send(@cargar_dlg, append, button('Cancelar', message(@prolog, acc_cargar_cancelar)), right),
        send(@cargar_dlg, open_centered)
    ).

acc_cargar_confirmar :-
    ( object(@cargar_lb), get(@cargar_lb, selection, Sel), Sel \== @nil ->
        get(Sel, key, Archivo),
        carrera_actual(Carrera),
        cargar_expediente(Archivo, Leido),
        ( Leido = sesion_xpce(CarreraArchivo, ListaLeida) ->
            ( CarreraArchivo == Carrera ->
                maplist(normalizar_codigo, ListaLeida, Normalizados),
                include(acc_filtrar_cod(Carrera), Normalizados, Limpio),
                sort(Limpio, Final),
                reemplazar_expediente(Final),
                set_archivo_sesion_actual(Archivo),
                actualizar_browser_expediente,
                actualizar_estado_lbl,
                format(atom(T), '[CARGADO] Sesion restaurada desde:\n~w\nCarrera validada: ~w\nMaterias restauradas: ~w', [Archivo, Carrera, Final]),
                mostrar_resultado(T),
                ( object(@cargar_dlg) -> send(@cargar_dlg, destroy) ; true )
            ;
                format(atom(T), '[DENEGADO] El archivo pertenece a la carrera ~w, pero tu carrera actual es ~w.\n\nCambia la carrera activa o carga un archivo compatible.', [CarreraArchivo, Carrera]),
                mostrar_resultado(T),
                send(@display, inform, 'La sesion seleccionada corresponde a otra carrera.')
            )
        ; Leido = [_|_] ->
            T = '[DENEGADO] El archivo no tiene identificador de carrera (formato antiguo).\n\nPor seguridad no se puede cargar porque no se puede validar compatibilidad.',
            mostrar_resultado(T),
            send(@display, inform, 'Archivo de sesion antiguo sin identificador de carrera.')
        ;
            T = '[ERROR] El archivo de sesion tiene un formato invalido o esta corrupto.',
            mostrar_resultado(T),
            send(@display, inform, 'No se pudo leer el archivo de sesion seleccionado.')
        )
    ;
        send(@display, inform, 'Selecciona un archivo de la lista primero.')
    ).

guardar_sesion_xpce(Carrera, Expediente, Archivo) :-
    open(Archivo, write, Stream),
    writeq(Stream, sesion_xpce(Carrera, Expediente)),
    write(Stream, '.'),
    close(Stream).

% Convierte codigos numericos (203) a atomos de 4 digitos ('0203')
normalizar_codigo(Cod, Atom) :-
    ( number(Cod) ->
        format(atom(Atom), '~`0t~d~4|', [Cod])
    ;
        Atom = Cod
    ).

acc_cargar_cancelar :-
    ( object(@cargar_dlg) -> send(@cargar_dlg, destroy) ; true ).

acc_filtrar_cod(Carrera, Codigo) :-
    materia(Carrera, Codigo, _, _, _, _, _, _).

% =====================================================
% HANDLERS DE BUSQUEDA
% =====================================================

acc_buscar_catalogo(Arg) :-
    ( object(Arg), send(Arg, instance_of, char_array) ->
        get(Arg, value, TextoAtom)
    ; 
        TextoAtom = Arg 
    ),
    retractall(filtro_catalogo(_)),
    asserta(filtro_catalogo(TextoAtom)),
    llenar_catalogo_materias.

acc_buscar_limpiar :-
    send(@txt_buscar, selection, ''),
    retractall(filtro_catalogo(_)),
    asserta(filtro_catalogo('')),
    llenar_catalogo_materias.

normalizar_cadena(Texto, Normalizado) :-
    downcase_atom(Texto, Min),
    atom_chars(Min, Chars),
    maplist(quitar_acento_char, Chars, CharsOut),
    atom_chars(Normalizado, CharsOut).

quitar_acento_char(C, 'a') :- char_code(C, 225), !.
quitar_acento_char(C, 'e') :- char_code(C, 233), !.
quitar_acento_char(C, 'i') :- char_code(C, 237), !.
quitar_acento_char(C, 'o') :- char_code(C, 243), !.
quitar_acento_char(C, 'u') :- char_code(C, 250), !.
quitar_acento_char(C, 'a') :- char_code(C, 193), !.
quitar_acento_char(C, 'e') :- char_code(C, 201), !.
quitar_acento_char(C, 'i') :- char_code(C, 205), !.
quitar_acento_char(C, 'o') :- char_code(C, 211), !.
quitar_acento_char(C, 'u') :- char_code(C, 218), !.
quitar_acento_char(C, C) :- !.
