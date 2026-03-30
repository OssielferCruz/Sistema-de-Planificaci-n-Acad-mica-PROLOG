:- use_module(library(pce)).
:- ensure_loaded('motor_inferencia.pl').

:- dynamic expediente_actual/1.
:- dynamic carrera_actual/1.

expediente_actual([]).
carrera_actual(ice).

% ========================================================
% BLOQUE 1 Y 2: VENTANA PRINCIPAL Y LIST BROWSER
% ========================================================

iniciar_sistema :-
    new(Ventana, dialog('Sistema Experto de Planificacion Academica - ICE 2026')),
    send(Ventana, size, size(1060, 700)),

    send(Ventana, append, new(Titulo, label(nombre, 'Planificador Academico ICE'))),
    send(Titulo, font, font(helvetica, bold, 16)),
    send(Titulo, colour, colour(blue)),

    send(Ventana, append, new(Catalogo, browser('Catalogo de materias')), point(20, 50)),
    send(Catalogo, size, size(45, 16)),
    llenar_catalogo_materias(Catalogo),

    send(Ventana, append, new(ExpBrowser, browser('Expediente aprobado')), point(400, 50)),
    send(ExpBrowser, size, size(30, 16)),
    actualizar_browser_expediente(ExpBrowser),

    send(Ventana, append, new(Resultado, editor), point(20, 390)),
    send(Resultado, size, size(118, 16)),
    send(Resultado, editable, @off),
    mostrar_en_resultado(Resultado, 'Selecciona una materia y usa los botones de accion.'),

    send(Ventana, append, button('Verificar requisitos', message(@prolog, accion_verificar, Catalogo?selection?key, Resultado)), point(20, 335)),
    send(Ventana, append, button('Ruta critica', message(@prolog, accion_ruta_critica, Catalogo?selection?key, Resultado)), point(165, 335)),
    send(Ventana, append, button('Simular matricula', message(@prolog, accion_simular_matricula, Resultado)), point(270, 335)),
    send(Ventana, append, button('Recomendar recuperacion', message(@prolog, accion_recomendar_recuperacion, Catalogo?selection?key, Resultado)), point(395, 335)),
    send(Ventana, append, button('Marcar aprobada', message(@prolog, accion_marcar_aprobada, Catalogo?selection?key, ExpBrowser, Resultado)), point(585, 335)),
    send(Ventana, append, button('Quitar aprobada', message(@prolog, accion_quitar_aprobada, ExpBrowser?selection?key, ExpBrowser, Resultado)), point(710, 335)),
    send(Ventana, append, button('Ver progreso', message(@prolog, accion_ver_progreso, Resultado)), point(830, 335)),
    send(Ventana, append, button('Guardar expediente', message(@prolog, accion_guardar, Resultado)), point(20, 365)),
    send(Ventana, append, button('Cargar expediente', message(@prolog, accion_cargar, ExpBrowser, Resultado)), point(155, 365)),

    send(Ventana, open_centered).

% Funcion de apoyo para llenar la lista
llenar_catalogo_materias(Catalogo) :-
    carrera_actual(Carrera),
    send(Catalogo, clear),
    forall(materia(Carrera, Codigo, Nombre, _, Cuatri, Creditos, _, _),
        (
            format(atom(TextoVisual), '[~w] ~w (C~w, ~w cr)', [Codigo, Nombre, Cuatri, Creditos]),
            send(Catalogo, append, dict_item(Codigo, TextoVisual))
        )
    ).

actualizar_browser_expediente(ExpBrowser) :-
    carrera_actual(Carrera),
    expediente_actual(Expediente),
    send(ExpBrowser, clear),
    forall(member(Codigo, Expediente),
        (
            materia(Carrera, Codigo, Nombre, _, _, _, _, _),
            format(atom(TextoVisual), '[~w] ~w', [Codigo, Nombre]),
            send(ExpBrowser, append, dict_item(Codigo, TextoVisual))
        )
    ).

mostrar_en_resultado(Resultado, Texto) :-
    send(Resultado, clear),
    send(Resultado, insert, Texto).

codigo_seleccionado_valido(Codigo) :-
    nonvar(Codigo),
    Codigo \== @nil.

set_expediente(Nuevo) :-
    retractall(expediente_actual(_)),
    asserta(expediente_actual(Nuevo)).

render_lista_materias(_, [], '(ninguna)\n').
render_lista_materias(Carrera, Codigos, Texto) :-
    findall(Linea,
        (
            member(Codigo, Codigos),
            materia(Carrera, Codigo, Nombre, _, Cuatri, Creditos, _, _),
            format(atom(Linea), ' - [~w] ~w | Cuatrimestre: ~w | Creditos: ~w~n', [Codigo, Nombre, Cuatri, Creditos])
        ),
        Lineas),
    atomic_list_concat(Lineas, '', Texto).

render_bloqueadas(_, [], '(ninguna)\n').
render_bloqueadas(Carrera, Bloqueadas, Texto) :-
    findall(Linea,
        (
            member(Codigo-Faltantes, Bloqueadas),
            materia(Carrera, Codigo, Nombre, _, _, _, _, _),
            atomic_list_concat(Faltantes, ', ', ReqTxt),
            format(atom(Linea), ' - [~w] ~w | Falta: ~w~n', [Codigo, Nombre, ReqTxt])
        ),
        Lineas),
    atomic_list_concat(Lineas, '', Texto).

accion_verificar(CodigoMateria, Resultado) :-
    (   \+ codigo_seleccionado_valido(CodigoMateria)
    ->  send(@display, inform, 'Selecciona una materia del catalogo.'),
        mostrar_en_resultado(Resultado, 'No hay materia seleccionada.')
    ;   carrera_actual(Carrera),
        expediente_actual(Expediente),
        (   member(CodigoMateria, Expediente)
        ->  format(atom(Txt), 'La materia [~w] ya esta aprobada en tu expediente.', [CodigoMateria]),
            mostrar_en_resultado(Resultado, Txt)
        ;   requisitos_pendientes(Carrera, CodigoMateria, Expediente, Faltantes),
            (   Faltantes == []
            ->  format(atom(Txt), 'Puedes matricular [~w]. Cumples todos los requisitos.', [CodigoMateria]),
                mostrar_en_resultado(Resultado, Txt)
            ;   atomic_list_concat(Faltantes, ', ', ListaFaltantes),
                format(atom(Txt), 'Aun no puedes matricular [~w]. Falta aprobar: ~w', [CodigoMateria, ListaFaltantes]),
                mostrar_en_resultado(Resultado, Txt),
                send(@display, inform, Txt)
            )
        )
    ).

accion_ruta_critica(CodigoMateria, Resultado) :-
    (   \+ codigo_seleccionado_valido(CodigoMateria)
    ->  send(@display, inform, 'Selecciona una materia del catalogo.'),
        mostrar_en_resultado(Resultado, 'No hay materia seleccionada.')
    ;   carrera_actual(Carrera),
        ruta_critica_atras(Carrera, CodigoMateria, RutaAtras),
        ruta_critica_adelante(Carrera, CodigoMateria, RutaAdelante),
        render_lista_materias(Carrera, RutaAtras, TxtAtras),
        render_lista_materias(Carrera, RutaAdelante, TxtAdelante),
        format(atom(Txt),
            'Ruta critica para [~w]\n\nHacia atras (dependencias):\n~w\nHacia adelante (desbloqueos):\n~w',
            [CodigoMateria, TxtAtras, TxtAdelante]),
        mostrar_en_resultado(Resultado, Txt)
    ).

accion_simular_matricula(Resultado) :-
    carrera_actual(Carrera),
    expediente_actual(Expediente),
    materias_habilitadas(Carrera, Expediente, Habilitadas),
    materias_bloqueadas(Carrera, Expediente, Bloqueadas),
    render_lista_materias(Carrera, Habilitadas, TxtHab),
    render_bloqueadas(Carrera, Bloqueadas, TxtBloq),
    format(atom(Txt),
        'Simulador de matricula\n\nMaterias habilitadas:\n~w\nMaterias bloqueadas:\n~w',
        [TxtHab, TxtBloq]),
    mostrar_en_resultado(Resultado, Txt).

accion_recomendar_recuperacion(CodigoMateria, Resultado) :-
    (   \+ codigo_seleccionado_valido(CodigoMateria)
    ->  send(@display, inform, 'Selecciona la materia reprobada a evaluar.'),
        mostrar_en_resultado(Resultado, 'No hay materia seleccionada.')
    ;   carrera_actual(Carrera),
        expediente_actual(Expediente),
        recomendar_recuperacion(Carrera, CodigoMateria, Prioridad),
        materias_adelantables(Carrera, Expediente, [CodigoMateria], Adelantables),
        render_lista_materias(Carrera, Adelantables, TxtAdelanto),
        format(atom(Txt),
            'Recomendador de recuperacion para [~w]\nPrioridad: ~w\n\nMaterias que puedes adelantar:\n~w',
            [CodigoMateria, Prioridad, TxtAdelanto]),
        mostrar_en_resultado(Resultado, Txt)
    ).

accion_marcar_aprobada(CodigoMateria, ExpBrowser, Resultado) :-
    (   \+ codigo_seleccionado_valido(CodigoMateria)
    ->  send(@display, inform, 'Selecciona una materia del catalogo para marcarla.'),
        mostrar_en_resultado(Resultado, 'No hay materia seleccionada para marcar.')
    ;   expediente_actual(Expediente),
        (   member(CodigoMateria, Expediente)
        ->  format(atom(Txt), 'La materia [~w] ya estaba marcada como aprobada.', [CodigoMateria]),
            mostrar_en_resultado(Resultado, Txt)
        ;   append(Expediente, [CodigoMateria], NuevoExpediente),
            sort(NuevoExpediente, Ordenado),
            set_expediente(Ordenado),
            actualizar_browser_expediente(ExpBrowser),
            format(atom(Txt), 'Materia [~w] agregada al expediente.', [CodigoMateria]),
            mostrar_en_resultado(Resultado, Txt)
        )
    ).

accion_quitar_aprobada(CodigoMateria, ExpBrowser, Resultado) :-
    (   \+ codigo_seleccionado_valido(CodigoMateria)
    ->  send(@display, inform, 'Selecciona una materia del expediente para quitarla.'),
        mostrar_en_resultado(Resultado, 'No hay materia seleccionada para quitar.')
    ;   expediente_actual(Expediente),
        select(CodigoMateria, Expediente, NuevoExpediente),
        set_expediente(NuevoExpediente),
        actualizar_browser_expediente(ExpBrowser),
        format(atom(Txt), 'Materia [~w] removida del expediente.', [CodigoMateria]),
        mostrar_en_resultado(Resultado, Txt)
    ), !.
accion_quitar_aprobada(_, _, Resultado) :-
    mostrar_en_resultado(Resultado, 'La materia seleccionada no existe en el expediente actual.').

accion_ver_progreso(Resultado) :-
    carrera_actual(Carrera),
    expediente_actual(Expediente),
    progreso_creditos(Carrera, Expediente, Aprobados, Restantes, Total),
    format(atom(Txt), 'Progreso academico\nCreditos aprobados: ~w\nCreditos restantes: ~w\nTotal plan: ~w', [Aprobados, Restantes, Total]),
    mostrar_en_resultado(Resultado, Txt).

accion_guardar(Resultado) :-
    expediente_actual(Expediente),
    (   get(@finder, file, save, Archivo), Archivo \== @nil
    ->  guardar_expediente(Expediente, Archivo),
        format(atom(Txt), 'Expediente guardado en: ~w', [Archivo]),
        mostrar_en_resultado(Resultado, Txt)
    ;   mostrar_en_resultado(Resultado, 'Guardado cancelado por el usuario.')
    ).

accion_cargar(ExpBrowser, Resultado) :-
    carrera_actual(Carrera),
    (   get(@finder, file, open, Archivo), Archivo \== @nil
    ->  cargar_expediente(Archivo, ExpedienteLeido),
        include(es_codigo_de_carrera(Carrera), ExpedienteLeido, ExpedienteLimpio),
        sort(ExpedienteLimpio, ExpedienteFinal),
        set_expediente(ExpedienteFinal),
        actualizar_browser_expediente(ExpBrowser),
        format(atom(Txt), 'Expediente cargado desde: ~w', [Archivo]),
        mostrar_en_resultado(Resultado, Txt)
    ;   mostrar_en_resultado(Resultado, 'Carga cancelada por el usuario.')
    ).

es_codigo_de_carrera(Carrera, Codigo) :-
    materia(Carrera, Codigo, _, _, _, _, _, _).
