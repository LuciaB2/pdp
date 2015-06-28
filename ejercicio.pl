esAgua(nestle).
costo(nestle, 9).
esGaseosa(coca).
costo(coca,18).
esAlcoholica(quilmes).
esNacional(quilmes).
costo(quilmes,30).
esAlcoholica(tequila).
esImportada(tequila).
costo(tequila,130).
esComerciante(juan).
esParticular(ana).

recargo(Cliente,Bebida,Recargo):-
 esComerciante(Cliente),
 esAgua(Bebida),
 costo(Bebida, PrecioBebida),
 Recargo is PrecioBebida * 0.25.

recargo(Cliente,Bebida,Recargo):-
 esComerciante(Cliente),
 esAlcoholica(Bebida),
 costo(Bebida, PrecioBebida),
 Recargo is PrecioBebida * 0.3.

recargo(Cliente,Bebida,Recargo):-
 esParticular(Cliente),
 esAgua(Bebida),
 costo(Bebida, PrecioBebida),
 Recargo is PrecioBebida * 0.3.

recargo(Cliente,Bebida,Recargo):-
 esParticular(Cliente),
 esGaseosa(Bebida),
 costo(Bebida, PrecioBebida),
 Recargo is PrecioBebida * 0.4.

recargo(Cliente,Bebida,Recargo):-
 esParticular(Cliente),
 esAlcoholica(Bebida),
 esNacional(Bebida),
 costo(Bebida, PrecioBebida),
 Recargo is PrecioBebida * 0.6.

recargo(Cliente,Bebida,Recargo):-
 esParticular(Cliente),
 esAlcoholica(Bebida),
 esImportada(Bebida),
 costo(Bebida, PrecioBebida),
 Recargo is PrecioBebida * 0.7.

calcularPrecio(Cliente, Bebida, Precio):-
 esComerciante(Cliente),
 esGaseosa(Bebida),
 costo(Bebida,Precio).


calcularPrecio(Cliente, Bebida, Precio):-
 costo(Bebida,PrecioBebida),
 recargo(Cliente, Bebida, Recargo),
 Precio is PrecioBebida + Recargo.

metrosLanzamiento(ricky,10).
metrosLanzamiento(lowy,8).

puntajeMetros(Competidor,Metros,0):-
 metrosLanzamiento(Competidor,Metros),
 between(0,7,Metros).

puntajeMetros(Competidor,Metros,0):-
 metrosLanzamiento(Competidor,Metros),
 Metros >= 15.

puntajeMetros(Competidor,Metros,6):-
 metrosLanzamiento(Competidor,Metros),
 between(7,9,Metros).

puntajeMetros(Competidor,Metros,6):-
 metrosLanzamiento(Competidor,Metros),
 between(11,15,Metros).

puntajeMetros(Competidor,Metros,10):-
 metrosLanzamiento(Competidor,Metros),
 between(9,11,Metros).

puntajeFuerzaMartillo(Competidor,3):-
 metrosMartillo(Competidor,Metros),
 between(0,5,Metros).

puntajeFuerzaMartillo(Competidor,6):-
 metrosMartillo(Competidor,Metros),
 between(5,10,Metros).

puntajeFuerzaMartillo(Competidor,Puntaje):-
 metrosMartillo(Competidor,Metros),
 Metros >= 10,
 MetrosExtra is Metros - 10,
 PuntosAdicionales is 2 * MetrosExtra,
 Puntaje is 10 + PuntosAdicionales.

metrosMartillo(ricky,12).
puntajeEquilibrioEscoba(ricky,9).
puntajeLanzamientoPrecision(ricky,12).

puntajeTotal(Competidor,PuntajeTotal):-
 puntajeLanzamientoPrecision(Competidor,PuntajePrecision),
 PuntajePrecision > 5,
 puntajeFuerzaMartillo(Competidor,PuntajeMartillo),
 PuntajeMartillo > 5,
 puntajeEquilibrioEscoba(Competidor,PuntajeEscoba),
 PuntajeEscoba > 5,
 PuntajeTotal is PuntajePrecision + PuntajeMartillo + PuntajeEscoba.

viveEn(agatha,mansionDreadbury).
viveEn(carnicero,mansionDreadbury).
viveEn(charles,mansionDreadbury).

odia(charles, Persona):-
 viveEn(Persona,mansionDreadbury),
 not(odia(agatha, Persona)).

odia(agatha, Persona):-
 viveEn(Persona,mansionDreadbury),
 Persona \= carnicero.

masRico(Persona, agatha):-
 not(odia(carnicero, Persona)),
 viveEn(Persona,mansionDreadbury).

odia(carnicero, Persona):-
 odia(agatha, Persona),
 Persona \= agatha.

asesino(agatha, Asesino):-
 odia(Asesino, agatha),
 masRico(agatha, Asesino),
 viveEn(Asesino,mansionDreadbury).

puntajeEquilibroEscoba(Persona,Puntaje):-
 metrosEscoba(Persona, Metros),
 puntosPorMetros(Puntos,Metros),
 Puntaje is round(Puntos).


puntosPorMetros(Puntos, Metros):-
 Puntos is Metros / 3.

metrosEscoba(ricky,13).

puntajes(hernan,[3,5,8,6,9]).
puntajes(julio,[9,7,3,9,10,2]).
puntajes(ruben,[3,5,3,8,3]).
puntajes(roque,[10,10,7]).

puntajeCompetidor(Competidor, Salto, Puntaje):-
	puntajes(Competidor, PuntajeSaltos),
	nth1(Salto,PuntajeSaltos, Puntaje).

competidorDescalificado(Competidor):-
 puntajes(Competidor, PuntajeSaltos),
 length(PuntajeSaltos, CantidadDeSaltos),
 CantidadDeSaltos > 5.

competidorClasifica(Competidor):-
 puntajes(Competidor, PuntajeSaltos),
 member(Salto1, PuntajeSaltos),
 member(Salto2, PuntajeSaltos),
 Salto1>=8,
 Salto2>=8,
 Salto1 \= Salto2.

 competidorClasifica(Competidor):-
 puntajes(Competidor, PuntajeSaltos),
 sumlist(PuntajeSaltos, SumaDeSaltos),
 SumaDeSaltos >= 28.


ingresoTotal(Persona, IngresoTotal):-
 ingreso(Persona,_, Ingreso),
 ingresoTotal(Persona, IngresoTotal),
 IngresoTotal is Ingreso + IngresoTotal.

ingreso(roque,enero,2300).
ingreso(roque,febrero,3500).
ingreso(roque,marzo,1200).
ingreso(luisa,enero,2500).
ingreso(luisa,febrero,850).
