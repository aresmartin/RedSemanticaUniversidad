entregables(video).
entregables(memoria).

alumno(alumno1).
alumno(alumno2).

profesor(moreno).

insertar(X,[],[X]).
insertar(X, Lista, [X|Lista]).

mandar_hacer_un_trabajo(Profesor, L1, L2):-
    profesor(Profesor) &
    .findall(Alumno, alumno(Alumno), Alumnos) &
    .findall(Entregable, entregables(Entregable), Entregables) &
    despachar_entregables(Alumnos, Entregables, L1, L2).

mandar_hacer_un_trabajo(Profesor, L1, L2):-
    .print("mandar_hacer_un_trabajo NOK").
	
despachar_entregables(Alumnos, Entregable, L1, L2):-
    por_alumno(Alumnos, Entregable, L1, L2).
	
por_alumno([Alumno], Entregables, L1, L3):- por_entregable(Entregables, Alumno, L1, L3).
por_alumno([Alumno|Resto], Entregables, L1, L3):-
    por_entregable(Entregables, Alumno, L1, L2) &
	por_alumno(Resto, Entregables, L2, L3).

por_entregable([Entregable], Alumno, L1, L3):-
    insertar(trabajo_entregado(Alumno, Entregable), L1, L3).
por_entregable([Entregable|Resto], Alumno, L1, L3):-
    insertar(trabajo_entregado(Alumno, Entregable), L1, L2) &
	por_entregable(Resto, Alumno, L2, L3).

calificacion_random1(X):-
    Tope = 10 &
    .random(Val, Tope) &
    X = Val * 10 * 0.6.
	
calificacion_random2(X):-
    Tope = 10 &
    .random(Val, Tope) &
    X = Val * 10 * 0.4.

puntuar([Trabajo],Alumno, L1, L2):-
    calificacion_random1(Nota) &
    insertar(calificacion(Alumno, Trabajo, Nota), L1, L2) &
	.print(L2).

puntuar([Trabajo|Resto],Alumno, L1, L3):-
    calificacion_random2(Nota) &
    insertar(calificacion(Alumno,Trabajo, Nota), L1, L2) &
    puntuar(Resto, Alumno, L2, L3).
	

calificar_alumnos([Alumno],Trabajos, L1, L2):-
    .findall(X, trabajo_entregado(Alumno, X), Trabajos) &
	.print(Trabajos) &
    puntuar(Trabajos, Alumno, L1, L2).

calificar_alumnos([Alumno|Resto],Trabajos, L1, L3):-
    .findall(X, trabajo_entregado(Alumno, X), Trabajos) &
    puntuar(Trabajos, Alumno, L1, L2) &
    calificar_alumnos(Resto, Trabajos, L2, L3).

calificar_trabajos(Profesor, L1, L2):-
    profesor(Profesor) &
    .findall(Alumno, alumno(Alumno), Alumnos) &
    calificar_alumnos(Alumnos,Trabajos, L1, L2).

calificar_trabajos(Profesor, L1, L2):- .print(" calificar_trabajos NOK").

sumar([H], Acc, R):-
    R = Acc + H.
sumar([H|T], Acc, R):-
    Aux = Acc + H &
    sumar(T, Aux, R).

calcular_notas_finales([Alumno]):-
    .findall(X, calificacion(Alumno,_,X), Calificaciones) &
    sumar(Calificaciones, 0, R) &
    .print("Nota de ", Alumno, " es ", R/2).

calcular_notas_finales([Alumno|Resto]):-
    .findall(X, calificacion(Alumno,_,X), Calificaciones) &
    .print(Calificaciones) &
    sumar(Calificaciones, 0, R) &
    .print("Nota de ", Alumno, " es ", R/2) &
    calcular_notas_finales(Resto).

+!almacenar_beliefs(Beliefs) <-
    for ( .member(M,Beliefs) ) {
        +M;
    }.

!start.
+!start : true <-
    ?mandar_hacer_un_trabajo(moreno, [], Entregables);
    !almacenar_beliefs(Entregables);
    ?calificar_trabajos(moreno, [], Resultados);
    !almacenar_beliefs(Resultados);
    .findall(Alumno, alumno(Alumno), Alumnos);
    ?calcular_notas_finales(Alumnos).
