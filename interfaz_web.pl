:- ensure_loaded('motor_inferencia.pl').
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_files)).
:- use_module(library(http/json)).
:- use_module(library(lists)).

:- dynamic expediente_web/1.
expediente_web([]).

:- multifile user:file_search_path/2.
user:file_search_path(web, 'web').

:- http_handler(root(api/materias), api_materias, []).
:- http_handler(root(api/expediente), api_expediente, [method(get)]).
:- http_handler(root(api/expediente/agregar), api_expediente_agregar, [method(post)]).
:- http_handler(root(api/expediente/quitar), api_expediente_quitar, [method(post)]).
:- http_handler(root(api/expediente/guardar), api_expediente_guardar, [method(post)]).
:- http_handler(root(api/expediente/cargar), api_expediente_cargar, [method(post)]).
:- http_handler(root(api/verificar), api_verificar, [method(post)]).
:- http_handler(root(api/ruta), api_ruta, [method(post)]).
:- http_handler(root(api/simular), api_simular, [method(get)]).
:- http_handler(root(api/recomendar), api_recomendar, [method(post)]).
:- http_handler(root(api/progreso), api_progreso, [method(get)]).
:- http_handler(root(.), http_reply_from_files(web('.'), []), [prefix]).

carrera_actual(ice).

iniciar_web :-
    iniciar_web(8090).

iniciar_web(Puerto) :-
    (   http_current_server(http_dispatch, PortInfo),
        memberchk(port(Puerto), PortInfo)
    ->  format('Servidor ya activo en http://localhost:~w~n', [Puerto])
    ;   http_server(http_dispatch, [port(Puerto)]),
        format('Interfaz web en http://localhost:~w~n', [Puerto])
    ).

detener_web :-
    catch(http_stop_server(8080, []), _, true).

set_expediente_web(Nuevo) :-
    retractall(expediente_web(_)),
    asserta(expediente_web(Nuevo)).

normalizar_codigo(Valor, Codigo) :-
    (   string(Valor)
    ->  atom_string(Codigo, Valor)
    ;   atom(Valor)
    ->  Codigo = Valor
    ;   number(Valor)
    ->  number_string(Valor, S), atom_string(Codigo, S)
    ).

codigo_valido(Codigo) :-
    carrera_actual(Carrera),
    materia(Carrera, Codigo, _, _, _, _, _, _).

materia_json(Codigo, Dict) :-
    carrera_actual(Carrera),
    materia(Carrera, Codigo, Nombre, Ano, Cuatri, Creditos, Prerreq, Preced),
    Dict = _{
        codigo: Codigo,
        nombre: Nombre,
        ano: Ano,
        cuatrimestre: Cuatri,
        creditos: Creditos,
        prerrequisito: Prerreq,
        precedente: Preced
    }.

api_materias(_Request) :-
    carrera_actual(Carrera),
    findall(D,
        (
            materia(Carrera, Codigo, _, _, _, _, _, _),
            materia_json(Codigo, D)
        ),
        Materias),
    reply_json_dict(_{materias: Materias}).

api_expediente(_Request) :-
    expediente_web(Exp),
    reply_json_dict(_{expediente: Exp}).

api_expediente_agregar(Request) :-
    http_read_json_dict(Request, Body),
    normalizar_codigo(Body.codigo, Codigo),
    (   codigo_valido(Codigo)
    ->  expediente_web(Exp),
        sort([Codigo | Exp], Nuevo),
        set_expediente_web(Nuevo),
        reply_json_dict(_{ok: true, expediente: Nuevo})
    ;   reply_json_dict(_{ok: false, error: 'Codigo invalido'}, [status(400)])
    ).

api_expediente_quitar(Request) :-
    http_read_json_dict(Request, Body),
    normalizar_codigo(Body.codigo, Codigo),
    expediente_web(Exp),
    (   select(Codigo, Exp, Nuevo)
    ->  set_expediente_web(Nuevo),
        reply_json_dict(_{ok: true, expediente: Nuevo})
    ;   reply_json_dict(_{ok: false, error: 'Codigo no estaba en expediente'}, [status(400)])
    ).

api_expediente_guardar(Request) :-
    http_read_json_dict(Request, Body),
    Archivo = Body.archivo,
    expediente_web(Exp),
    guardar_expediente(Exp, Archivo),
    reply_json_dict(_{ok: true, archivo: Archivo}).

api_expediente_cargar(Request) :-
    http_read_json_dict(Request, Body),
    Archivo = Body.archivo,
    cargar_expediente(Archivo, ExpLeido),
    include(codigo_valido, ExpLeido, SoloValidos),
    sort(SoloValidos, Final),
    set_expediente_web(Final),
    reply_json_dict(_{ok: true, expediente: Final, archivo: Archivo}).

api_verificar(Request) :-
    http_read_json_dict(Request, Body),
    normalizar_codigo(Body.codigo, Codigo),
    carrera_actual(Carrera),
    expediente_web(Exp),
    (   \+ codigo_valido(Codigo)
    ->  reply_json_dict(_{ok: false, error: 'Codigo invalido'}, [status(400)])
    ;   member(Codigo, Exp)
    ->  reply_json_dict(_{ok: true, habilitado: false, ya_aprobada: true, faltantes: []})
    ;   requisitos_pendientes(Carrera, Codigo, Exp, Faltantes),
        (Faltantes == [] -> Hab = true ; Hab = false),
        reply_json_dict(_{ok: true, habilitado: Hab, ya_aprobada: false, faltantes: Faltantes})
    ).

api_ruta(Request) :-
    http_read_json_dict(Request, Body),
    normalizar_codigo(Body.codigo, Codigo),
    carrera_actual(Carrera),
    (   \+ codigo_valido(Codigo)
    ->  reply_json_dict(_{ok: false, error: 'Codigo invalido'}, [status(400)])
    ;   ruta_critica_atras(Carrera, Codigo, Atras),
        ruta_critica_adelante(Carrera, Codigo, Adelante),
        reply_json_dict(_{ok: true, atras: Atras, adelante: Adelante})
    ).

api_simular(_Request) :-
    carrera_actual(Carrera),
    expediente_web(Exp),
    materias_habilitadas(Carrera, Exp, Habilitadas),
    materias_bloqueadas(Carrera, Exp, Bloqueadas),
    reply_json_dict(_{ok: true, habilitadas: Habilitadas, bloqueadas: Bloqueadas}).

api_recomendar(Request) :-
    http_read_json_dict(Request, Body),
    normalizar_codigo(Body.codigo, Codigo),
    carrera_actual(Carrera),
    expediente_web(Exp),
    (   \+ codigo_valido(Codigo)
    ->  reply_json_dict(_{ok: false, error: 'Codigo invalido'}, [status(400)])
    ;   recomendar_recuperacion(Carrera, Codigo, Prioridad),
        materias_adelantables(Carrera, Exp, [Codigo], Adelantables),
        reply_json_dict(_{ok: true, prioridad: Prioridad, adelantables: Adelantables})
    ).

api_progreso(_Request) :-
    carrera_actual(Carrera),
    expediente_web(Exp),
    progreso_creditos(Carrera, Exp, Aprobados, Restantes, Total),
    reply_json_dict(_{ok: true, aprobados: Aprobados, restantes: Restantes, total: Total}).
