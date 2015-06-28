/* Una empresa está buscando candidatos para varios de sus sectores. Desarrollar una base de conocimiento con la siguiente información:

Roque es contador, honesto y joven
Ana es ingeniera y honesta
Cecilia es abogada
Nota: resolverlo de forma que la base se pueda consultar de la siguiente forma:

? honesto(Quien).
Quien = roque;
Quien = ana.

En prolog no compila, pero en mumuki dio OK
*/

joven(roque).
honesto(ana).
honesto(roque).
abogado(cecilia).
contador(roque).
ingeniera(ana).

persona(roque, contador).
persona(ana, ingeniero).
persona(cecilia, abogado).

profesion(Nombre,Profesion):- persona(Nombre, Profesion).

/*
Ahora queremos saber qué empleandos pueden servir para un sector dado.

Sabiendo que la base de conocimiento contiene hechos de la forma:

contador/1, honesto/1, ambicioso/1
trabajoEn/2: nos dice si un empleado trabajó antes en cierto lugar.
Desarrollar un predicado puedeAndar/2 que relaciona a un sector con un empleado si este puede trabajar allí. Considerar que:

en contaduria solo pueden trabajar contadores honestos
en ventas solo pueden trabajar ambiciosos que tienen experiencia (gente que haya trabajado en algun lugar antes)
y lucia siempre puede trabajar en ventas
*/


puedeAndar(lucia, ventas).
puedeAndar(Persona, contaduria):-
 contador(Persona);
 honesto(Persona).
puedeAndar(Persona,ventas):-
 ambicioso(Persona);
 tieneExperiencia(Persona,_).


tieneExperiencia(Persona, Sector):- trabajoEn(Persona, Sector).

