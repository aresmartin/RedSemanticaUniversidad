/*
	construir una simulación en la que un profesor solicita a un grupo de alumnos
	la realización de un trabajo que constará de dos entregas diferentes: 
	una memoria y un vídeo, que serán calificados por separado con un peso diferente
*/

/* Initial beliefs and rules */
//Beliefs posteriores: calificacion(Alumno, Trabajo, nota).
alumno(martin).
profesor(moreno).
tarea(video).
tarea(presentacion).
evaluacion(video, 0.3).
presentacion(prensentacion, 0.7).
trabajo(trabajo_final, [video, presentacion]).

/* Initial goals */

!start.

/* Plans */

+!start : true
	<- +nuevo_trabajo(moreno, trabajo_final).

+!proponer_trabajo <-true.

nuevo_trabajo(Profesor, NombreTrabajo):- profesor(Profesor) & trabajo(NombreTrabajo, Entregas) & despacha(Entregas).
	

//TODO: que ocurre si trabajo no existe
nuevo_trabajo(Profesor, NombreTrabajo).

//TODO: que pasa si el alumno o la entrega no existen
//realizar_entrega(Alumno, Entrega)
	//<- +entregable(Alumno, Entrega).
	
despachar_entregas([]).	
despachar_entregas([Car|Cdr]):- .print(Car) & desapachar_entregas(Cdr).
	
		



		
	
	
	
	
	
	
	
	
	
