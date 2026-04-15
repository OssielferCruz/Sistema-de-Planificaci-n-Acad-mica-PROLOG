
:- use_module(library(pce)).
test :-
    new(D, dialog('Test')),
    send(D, background, colour(white)),
    new(T, text_item('Nombre')),
    catch(send(T, background, colour(black)), E, print_message(error, E)),
    send(D, append, T),
    send(D, open).
:- test, halt.

