:- use_module(library(pce)).

:- dynamic filtro_catalogo/1.
filtro_catalogo('').

materia(ice, '0101', 'Matematica I', 1, 1, 3, ninguno, ninguno).
materia(ice, '0102', 'Matematica II', 1, 2, 3, '0101', ninguno).
materia(ice, '0702', 'Introduccion a la Programacion', 1, 3, 3, ninguno, ninguno).

carrera_actual(ice).

iniciar_sistema :-
    new(@v_main, dialog('Test Busqueda')),
    new(GLists, dialog_group('Materias')),
    
    new(@txt_buscar, text_item('Buscar en Catalogo (Enter):', '')),
    send(@txt_buscar, message, message(@prolog, acc_buscar_catalogo, @receiver?selection)),
    send(GLists, append, @txt_buscar),
    send(GLists, append, button('Limpiar', message(@prolog, acc_buscar_limpiar)), right),
    
    new(@cat_browser, browser('Catalogo Oficial')),
    send(@cat_browser, size, size(58, 10)),
    llenar_catalogo_materias,
    
    new(@exp_browser, browser('Tu Expediente')),
    send(@exp_browser, size, size(45, 10)),

    send(GLists, append, @cat_browser),
    send(GLists, append, @exp_browser, right),

    send(@v_main, append, GLists),
    send(@v_main, open).

llenar_catalogo_materias :-
    carrera_actual(Carrera),
    filtro_catalogo(Filtro),
    downcase_atom(Filtro, FiltroL),
    send(@cat_browser, clear),
    forall(
        materia(Carrera, Codigo, Nombre, _, _, _, _, _),
        (
            downcase_atom(Nombre, NombreL),
            downcase_atom(Codigo, CodigoL),
            ( sub_atom(NombreL, _, _, _, FiltroL) ; sub_atom(CodigoL, _, _, _, FiltroL) )
            ->
            format(atom(Txt), '[~w] ~w', [Codigo, Nombre]),
            send(@cat_browser, append, dict_item(Codigo, Txt))
            ; true
        )
    ).

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

test :- iniciar_sistema.
