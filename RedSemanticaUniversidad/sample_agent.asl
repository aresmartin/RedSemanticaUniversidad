// Agent sample_agent in project ejemplo

/* Initial beliefs and rules */

/* Initial goals */

genera_calificaciones(Alumno):-
	Puntuacion = 10 &
	.random(X, Puntuacion) &
	L = X * 10 &
	.print(Alumno, " tiene un calificacion de: ", L).

por_alumno([], _).
por_alumno([Car|Cdr], Trabajo):- 
	.print("Alumno ", Car, " hace trabajo ", Trabajo) &
	por_alumno(Cdr, Trabajo).


por_trabajo([], _).
por_trabajo([Car|Cdr], Alumnos):- 
	por_alumno(Alumnos, Car) & 
	por_trabajo(Cdr, Alumnos).

trabajo(entrega).
trabajo(presentacion).

alumno(david).
alumno(martin).

alumnos:- 
	.findall(Al, alumno(Al), A) & 
	.findall(Tr, trabajo(Tr), T) & 
	.print(T) & 
	por_trabajo(T, A) & 
	genera_calificaciones(A). 

alumnos.	
!start.

/* Plans */

+!start : true <- .print("hello world."); ?alumnos.
