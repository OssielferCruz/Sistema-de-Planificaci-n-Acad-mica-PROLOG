:- use_module(library(pce)).

test :-
    new(D, dialog('Test Layout')),
    send(D, size, size(1000, 700)),
    send(D, background, colour(white)),
    send(D, gap, size(15, 8)),

    % Titulo
    send(D, append, new(L, label(lt, 'Titulo'))),
    send(L, font, font(helvetica, bold, 18)),

    % Buscador
    send(D, append, new(_, text_item('Buscar:', '')), below),

    % Browser 1 (Cursos)
    new(B1, browser('Cursos')),
    send(B1, size, size(40, 10)),
    send(D, append, B1, below),
    send(B1, append, dict_item(a, 'Item A')),
    send(B1, append, dict_item(b, 'Item B')),

    % Browser 2 (Expediente) al lado
    new(B2, browser('Mi expediente')),
    send(B2, size, size(40, 10)),
    send(D, append, B2, right),

    % Resultados abajo
    new(GRes, dialog_group('Resultados Herramientas')),
    new(Ed, editor),
    send(Ed, size, size(40, 8)),
    send(Ed, editable, @off),
    send(GRes, append, Ed),
    send(D, append, GRes, below),

    % Botones al lado
    new(GBtn, dialog_group('Botones de Accion')),
    send(GBtn, append, button('Boton 1', message(@prolog, true))),
    send(GBtn, append, button('Boton 2', message(@prolog, true)), below),
    send(GBtn, append, button('Boton 3', message(@prolog, true)), below),
    send(D, append, GBtn, right),

    send(D, open_centered).
