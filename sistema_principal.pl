:- use_module(library(pce)). % Importar la librería gráfica nativa
:- ensure_loaded('motor_inferencia.pl'). % Importar nuestro cerebro matemático (que ya trae la BD)

% ========================================================
% BLOQUE 1 Y 2: VENTANA PRINCIPAL Y LIST BROWSER
% ========================================================

% iniciar_sistema/0
% Este es el comando maestro que usarás en consola para arrancar la aplicación Visual.
iniciar_sistema :-
    % 1. Crear el lienzo base de la ventana
    new(Ventana, dialog('Sistema Experto de Planificación Académica - Malla ICE 2026')),
    send(Ventana, size, size(600, 450)), % Un diseño minimalista y expandido ligeramente
    
    % 2. Agregar un título de bienvenida elegante
    send(Ventana, append, new(Titulo, label(nombre, 'Bienvenido al Planificador de Matrícula ICE'))),
    send(Titulo, font, font(helvetica, bold, 16)), % Fuente limpia
    send(Titulo, colour, colour(blue)), % XPCE requiere escritura británica 'colour'
    
    % 3. Componente List Browser (Catálogo Interactivo)
    % Esto evitará que escribas códigos a mano, mostrando todas las opciones.
    send(Ventana, append, new(Catalogo, browser('Selecciona una materia haciendo clic:'))),
    send(Catalogo, size, size(60, 15)), % Ajustar el cuadro de texto (Ancho x Alto)
    
    % Usamos nuestra función modular de abajo para llenarlo con las materias
    llenar_catalogo_materias(Catalogo),

    % 4. Abrir la ventana y centrarla en el monitor
    send(Ventana, open_centered).

% Función de apoyo para iterar la base de datos y llenar visualmente la lista
llenar_catalogo_materias(Catalogo) :-
    % El comando forall iterará nuestra base 'materia' extrayendo el Código y el Nombre
    forall(materia(ice, Codigo, Nombre, _, _, _, _, _),
        (
            % Pegar el texto bonito: Ej. "[0101] Matematicas I"
            atomic_list_concat(['[', Codigo, '] ', Nombre], TextoVisual),
            
            % Agregar el texto como un 'item' clickeable dentro de la lista de XPCE
            send(Catalogo, append, dict_item(Codigo, TextoVisual)) 
        )
    ).
