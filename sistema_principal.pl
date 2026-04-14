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

expediente_actual([]).
carrera_actual(ice).
filtro_catalogo('').


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

    % Crear ventana principal simple
    new(@v_main, dialog('Planificador Academico ICE 2026')),
    send(@v_main, size, size(1100, 720)),
    send(@v_main, background, colour(white)),
    
    % Titulo principal
    new(LTitle, label(titulo, 'Planificador Academico ICE 2026')),
    send(LTitle, font, font(helvetica, bold, 22)),
    send(LTitle, colour, colour(dark_green)),
    send(@v_main, append, LTitle),

    % ===============================
    % FILA 1: BUSCADOR (Top)
    % ===============================
    new(GSearch, dialog_group('')), send(GSearch, pen, 0),
    new(@txt_buscar, text_item('Buscar Curso:', '')),
    send(@txt_buscar, message, message(@prolog, acc_buscar_catalogo, @receiver?selection)),
    send(GSearch, append, @txt_buscar),
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

    % Estilizar botones
    send_list([B1,B2,B3,B4,B5,B6,B7,B8,B9], font, font(helvetica, bold, 10)),

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

    % Ensamblar columnas a v_main
    send(@v_main, append, GLeft, below),
    send(@v_main, append, GRight, right),

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

reemplazar_expediente(L) :-
    retractall(expediente_actual(_)),
    asserta(expediente_actual(L)).

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
          atomic_list_concat(Fs, ', ', StFs),
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
                atomic_list_concat(Faltantes, ', ', StrFs),
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

acc_guardar :-
    expediente_actual(Exp),
    ( get(@finder, file, save, Archivo), Archivo \== @nil ->
        guardar_expediente(Exp, Archivo),
        format(atom(T), '[GUARDADO] Expediente guardado exitosamente en:\n~w', [Archivo]),
        mostrar_resultado(T)
    ;
        mostrar_resultado('[CANCELADO] Guardado cancelado por el usuario.')
    ).

acc_cargar :-
    carrera_actual(Carrera),
    ( get(@finder, file, open, Archivo), Archivo \== @nil ->
        cargar_expediente(Archivo, Leido),
        include(acc_filtrar_cod(Carrera), Leido, Limpio),
        sort(Limpio, Final),
        reemplazar_expediente(Final),
        actualizar_browser_expediente,
        actualizar_estado_lbl,
        format(atom(T), '[CARGADO] Expediente cargado en el sistema desde:\n~w', [Archivo]),
        mostrar_resultado(T)
    ;
        mostrar_resultado('[CANCELADO] Carga de expediente cancelada.')
    ).

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
