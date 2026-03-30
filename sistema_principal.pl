:- use_module(library(pce)). % Importar la librería gráfica nativa
:- ensure_loaded('motor_inferencia.pl'). % Importar nuestro cerebro matemático (que ya trae la BD)

% ========================================================
% BLOQUE 1 Y 2: VENTANA PRINCIPAL Y LIST BROWSER
% ========================================================

iniciar_sistema :-
    % 1. Crear el lienzo base de la ventana
    new(Ventana, dialog('Sistema Experto de Planificacion Academica - Malla ICE 2026')),
    send(Ventana, size, size(600, 500)),
    
    % 2. Agregar un título de bienvenida elegante
    send(Ventana, append, new(Titulo, label(nombre, 'Bienvenido al Planificador de Matricula ICE'))),
    send(Titulo, font, font(helvetica, bold, 16)),
    send(Titulo, colour, colour(blue)),
    
    % 3. Componente List Browser (Catálogo Interactivo)
    send(Ventana, append, new(Catalogo, browser('Selecciona una materia haciendo clic:'))),
    send(Catalogo, size, size(60, 15)),
    llenar_catalogo_materias(Catalogo),

    % ========================================================
    % BLOQUE 3: BOTONES DE ACCIÓN (CONECTORES)
    % ========================================================
    % Estos 4 botones extraen dinámicamente el código de la materia (key) que tú tengas seleccionada
    % en el Browser y se lo envían al motor de Prolog a través de un "mensaje".
    
    send(Ventana, append, button('Verificar Requisitos', message(@prolog, accion_verificar, Catalogo?selection?key))),
    send(Ventana, append, button('Simular Ruta Critica Backward', message(@prolog, accion_ruta_atras, Catalogo?selection?key))),
    send(Ventana, append, button('Guardar Expediente Local', message(@prolog, accion_guardar))),
    send(Ventana, append, button('Cargar Expediente Local', message(@prolog, accion_cargar))),

    % 4. Mostrar ventana
    send(Ventana, open_centered).

% Función de apoyo (Bloque 2)
llenar_catalogo_materias(Catalogo) :-
    forall(materia(ice, Codigo, Nombre, _, _, _, _, _),
        (
            atomic_list_concat(['[', Codigo, '] ', Nombre], TextoVisual),
            send(Catalogo, append, dict_item(Codigo, TextoVisual)) 
        )
    ).

% ========================================================
% STUBS DE PRUEBA (Para no causar errores al hacer clic)
% ========================================================
accion_verificar(CodigoMateria) :- writeln('-> Verificando requisitos para: '), writeln(CodigoMateria).
accion_ruta_atras(CodigoMateria) :- writeln('-> Trazando ruta para: '), writeln(CodigoMateria).
accion_guardar :- writeln('-> Boton Guardar presionado.').
accion_cargar :- writeln('-> Boton Cargar presionado.').
