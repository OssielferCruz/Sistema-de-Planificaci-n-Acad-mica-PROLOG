:- use_module(library(pce)).

test :-
    new(D, dialog('Test Colors')),
    send(D, background, colour(white)),

    new(B, browser),
    send(B, size, size(30, 5)),
    send(B, background, colour(white)),
    
    send(B, style, estilo_negro, style(colour:=colour(black))),
    send(B, append, dict_item(1, 'Item 1', @default, estilo_negro)),
    send(B, append, dict_item(2, 'Item 2', @default, estilo_negro)),
    send(D, append, B),
    send(D, open).

