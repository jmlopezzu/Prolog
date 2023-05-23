% Codigo modificado para ejecutar las preguntas del diagnostico
iniciar :-
    new(Menu, dialog('* DETECTAR ERRORES EN CODIGO PYTHON *', size(1200, 1000))),
    new(L, label(nombre, 'Diagnostico de errores en codigo Python')),
    new(@texto, label(nombre, 'Fase de problemas encontrados en el codigo')),
    new(@respl, label(nombre, '')),
    new(A, label(nombre, 'Sistema de Ayuda y Diagnostico - 2023')),
    new(@boton, button('Ingresar al Sistema', message(@prolog, botones))),
    new(Salir, button('SALIR', and(message(Menu, destroy), message(Menu, free)))),
    new(@textInput, text_item('Ingrese su texto aquí')),

    send(Menu, append(L)), new(@btncarrera, button(' Hallazgos ')),
    send(Menu, display, L, point(100, 20)),
    send(Menu, display, @texto, point(40, 100)),
    send(Menu, display, @respl, point(20, 140)),
    send(Menu, display, A, point(80, 220)),
    send(Menu, display, @boton, point(140, 300)),
    send(Menu, display, Salir, point(160, 360)),
    send(Menu, append(@textInput)),

    send(Menu, open_centered).

botones :- lim,
    send(@boton, free),
    send(@btncarrera, free),
    errores(Error),
    send(@texto, selection('La posible solucion es ')),
    send(@respl, selection(Error)),
    new(@boton, button('Iniciar proceso de diagnostico', message(@prolog, botones))),
    send(Menu, display, @boton, point(40, 50)),
    send(Menu, display, @btncarrera, point(20, 50)),
    limpiar.

lim :- send(@respl, selection('')).

% Soluciones propuestas según los errores detectados en el codigo Python.
errores('Revisa la sintaxis de tu codigo, puede que tengas un error de escritura.'):- sintaxis,!.
errores('Parece que hay un problema con las dependencias de tu proyecto. Asegúrate de que todas las bibliotecas necesarias esten instaladas correctamente.'):- dependencias,!.
errores('Podría haber un problema con la definicion de variables. Asegúrate de que todas las variables esten correctamente definidas y utilizadas.'):- variables,!.
errores('Tu codigo puede tener un problema de logica. Revisa las estructuras de control y las operaciones matematicas.'):- logica,!.
errores('¡Sin resultados! Con los datos proporcionados no es posible llegar a un diagnostico.').

% Preguntas para resolver los errores con su respectivo identificador de error.
sintaxis:- 
    pregunta('¿Recibes errores de sintaxis al ejecutar tu codigo?'),
    pregunta('¿Has hecho cambios recientes en tu codigo que no has probado?'),
    pregunta('¿Has revisado tu codigo en busca de errores de escritura o sintaxis?').

dependencias:- 
    pregunta('¿Recibes errores de importacion al ejecutar tu codigo?'),
    pregunta('¿Has anadido nuevas bibliotecas a tu proyecto recientemente?'),
    pregunta('¿Has actualizado las versiones de las bibliotecas que estas utilizando?').

variables:- 
    pregunta('¿Recibes errores de variables no definidas o no utilizadas?'),
    pregunta('¿Estas seguro de que todas las variables estan definidas antes de ser utilizadas?'),
    pregunta('¿Has cambiado recientemente el valor o el uso de alguna variable?').

logica:-
    pregunta('¿Tu codigo se ejecuta pero los resultados no son los esperados?'),
    pregunta('¿Has probado la logica de tu codigo con diferentes entradas?'),
    pregunta('¿Estas utilizando las estructuras de control de flujo correctamente (bucles, condiciones, etc.)?').

% Identificador de problemas - Una pregunta que dirige a las nuevas preguntas.
identificar_sintaxis:- pregunta('¿Crees que el problema puede estar relacionado con la sintaxis de tu codigo?'),!.
identificar_dependencias:- pregunta('¿Crees que hay un problema con las dependencias de tu proyecto?'),!.
identificar_variables:- pregunta('¿Crees que hay un problema con las variables en tu codigo?'),!.
identificar_logica:- pregunta('¿Piensas que hay un problema de logica en tu codigo?'),!.

% Proceso del diagnostico a partir de respuestas (si/no).
:- dynamic si/1,no/1.

preguntar(Problema):- 
    new(Di,dialog('Diagnostico de errores en codigo Python')),
    new(L2,label(texto,'Por favor, responde con certeza, de acuerdo a lo que ves en tu codigo...')),
    new(La,label(prob,Problema)),
    new(B1,button(si,and(message(Di,return,si)))),
    new(B2,button(no,and(message(Di,return,no)))),

    send(Di,append(L2)),
    send(Di,append(La)),
    send(Di,append(B1)),
    send(Di,append(B2)),

    send(Di,default_button,si),
    send(Di,open_centered),
    get(Di,confirm,Answer),
    write(Answer),
    send(Di,destroy),
    ((Answer==si)->assert(si(Problema)); assert(no(Problema)),fail).

% Limpiar pantalla para cada nueva pregunta.
pregunta(S):-(si(S)->true; (no(S)->false; preguntar(S))).
limpiar :- retract(si(_)),fail.
limpiar :- retract(no(_)),fail.
limpiar.

% Diagnostico y seleccion con base en las respuestas a las preguntas.
botones :- 
    lim,
    send(@boton,free),
    send(@btncarrera,free),
    errores(Error),
    send(@texto,selection('La posible solucion es ')),
    send(@respl,selection(Error)),
    new(@boton,button('Iniciar proceso de diagnostico', message(@prolog, botones))),
    send(Menu,display,@boton,point(40,50)),
    send(Menu,display,@btncarrera,point(20,50)),
    limpiar.

lim :- send(@respl, selection('')).

% Ejecutar el sistema.
:- iniciar.