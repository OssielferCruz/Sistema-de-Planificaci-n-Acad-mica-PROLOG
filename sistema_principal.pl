:- use_module(library(pce)). % Importar la libreria grafica nativa
:- ensure_loaded('motor_inferencia.pl'). % Importar nuestro cerebro matematico (que ya trae la BD)

% ========================================================
% BLOQUE 1 Y 2: VENTANA PRINCIPAL Y LIST BROWSER
% ========================================================

% iniciar_sistema/0
% Este es el comando maestro que usaras en consola para arrancar la aplicacion Visual.
iniciar_sistema :-
    % 1. Crear el lienzo base de la ventana
    new(Ventana, dialog('Sistema Experto de Planificacion Academica - Malla ICE 2026')),
    send(Ventana, size, size(600, 450)), % Un diseno minimalista y expandido ligeramente
    
    % 2. Agregar un titulo de bienvenida elegante
    send(Ventana, append, new(Titulo, label(nombre, 'Bienvenido al Planificador de Matricula ICE'))),
    send(Titulo, font, font(helvetica, bold, 16)), % Fuente limpia
    send(Titulo, colour, colour(blue)), % XPCE requiere escritura britanica 'colour'
    
    % 3. Componente List Browser (Catalogo Interactivo)
    % Esto evitara que escribas codigos a mano, mostrando todas las opciones.
    send(Ventana, append, new(Catalogo, browser('Selecciona una materia haciendo clic:'))),
    send(Catalogo, size, size(60, 15)), % Ajustar el cuadro de texto (Ancho x Alto)
    
    % Usamos nuestra funcion modular de abajo para llenarlo con las materias
    llenar_catalogo_materias(Catalogo),

    % 4. Abrir la ventana y centrarla en el monitor
    send(Ventana, open_centered).

% Funcion de apoyo para iterar la base de datos y llenar visualmente la lista
llenar_catalogo_materias(Catalogo) :-
    % El comando forall iterara nuestra base 'materia' extrayendo el Codigo y el Nombre
    forall(materia(ice, Codigo, Nombre, _, _, _, _, _),
        (
            % Pegar el texto bonito: Ej. "[0101] Matematicas I"
            atomic_list_concat(['[', Codigo, '] ', Nombre], TextoVisual),
            
            % Agregar el texto como un 'item' clickeable dentro de la lista de XPCE
            send(Catalogo, append, dict_item(Codigo, TextoVisual)) 
        )
    ).
