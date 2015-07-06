%comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia,3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)).
comio(pumba, cucaracha(erikElRojo,25,70)).
comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
comio(timon, cucaracha(cucurucha,12,5)).
comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).
comio(shenzi,hormiga(conCaraDeSimba)).
pesoHormiga(2).
%peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).
peso(scar, 300).
peso(shenzi, 400).
peso(banzai, 500).
peso(Animal,Peso):-
	vaquitaSanAntonio(Animal,Peso).
peso(Animal,Peso):-
	cucaracha(Animal,_,Peso).
peso(Animal,Peso):-
	hormiga(Animal),
	pesoHormiga(Peso).
persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).
persigue(scar, mufasa).
animal(Animal):-
	peso(Animal,_).
animal(Animal):-
	persigue(_,Animal).

bicho(Animal):-
	hormiga(Animal).
bicho(Animal):-
	vaquitaSanAntonio(Animal,_).
bicho(Animal):-
	cucaracha(Animal,_,_).

hormiga(Animal):-
	comio(_,hormiga(Animal)).
vaquitaSanAntonio(Animal,Peso):-
	comio(_, vaquitaSanAntonio(Animal,Peso)).
cucaracha(Animal,TamanioCucaracha,PesoCucaracha):-
	 comio(_,cucaracha(Animal,TamanioCucaracha,PesoCucaracha)).
come(Animal,Comida) :- comio(Animal,vaquitaSanAntonio(Comida,_)).
come(Animal,Comida) :- comio(Animal,hormiga(Comida)).
come(Animal,Comida) :- comio(Animal,cucaracha(Comida,_,_)).
come(Animal,Comida) :- persigue(Animal,Comida).

%1)a)
jugosita(cucaracha(NombreCucaracha, TamanioCucaracha, PesoCucaracha)):-
 cucaracha(NombreCucaracha,TamanioCucaracha,PesoCucaracha),
 cucaracha(NombreOtraCucaracha,TamanioCucaracha,PesoOtraCucaracha),
 NombreCucaracha \= NombreOtraCucaracha,
 PesoCucaracha > PesoOtraCucaracha.

%b)
hormigofilico(Personaje):-
	hormigasQueComio(Personaje,Hormigas),
	comioMasDeDosHormigas(Hormigas).


hormigasQueComio(Personaje,Hormigas):-
	comio(Personaje,_),
	findall(NombreHormiga, (comio(Personaje,hormiga(NombreHormiga))),Hormigas).


comioMasDeDosHormigas(Hormigas):-
	length(Hormigas, CantidadHormigas),
	CantidadHormigas >= 2.

%c)
cucarachofobico(Personaje):-
	comio(Personaje,_),
	noComioCucarachas(Personaje).

noComioCucarachas(Personaje):-
	not(comio(Personaje,cucaracha(_,_,_))).

%d)
picaron(pumba).
picaron(Personaje):-
	comioCucarachaJugosita(Personaje).
picaron(Personaje):-
	comio(Personaje, vaquitaSanAntonio(remeditos,_)).

comioCucarachaJugosita(Personaje):-
	comio(Personaje, cucaracha(NombreCucaracha,TamanioCucaracha,PesoCucaracha)),
	jugosita(cucaracha(NombreCucaracha,TamanioCucaracha,PesoCucaracha)).

picarones(ListaDePersonajes):-
	findall(Personaje, picaron(Personaje), ListaDePersonajes).

%2%a)
cuantoEngorda(Animal, PesoTotal):-
	animal(Animal),
	findall(Peso, engorda(Animal,Peso),Pesos),
	sumlist(Pesos,PesoTotal).

engorda(Animal, Peso):-
	bicho(Bicho),
	come(Animal, Bicho),
	peso(Bicho,Peso).

%b)
engordaPersecutor(Animal, Peso):-
	come(Animal, Victima),
	peso(Victima,Peso).

cuantoEngordaPersecutor(Animal,PesoTotal):-
	animal(Animal),
	findall(Peso, engordaPersecutor(Animal,Peso),Pesos),
	sumlist(Pesos,PesoTotal).

%c)
engordaVictima(Animal, 0):-
	bicho(Animal).
engordaVictima(Victima, Peso):-
	bicho(Bicho),
	come(Victima, Bicho),
	peso(Bicho, Peso).
engordaVictima(Victima, PesoV):-
	bicho(bicho),
	come(Victima, Bicho),
	peso(Bicho,Peso),
	findall(Peso, engordaVictima(Victima, Peso), Pesos),
	sumlist(Pesos, PesoV).


cuantoEngordaPersecutorPaciente(Animal, 0):-
	bicho(Animal).
cuantoEngordaPersecutorPaciente(Animal,PesoTotal):-
	animal(Animal),
	findall(Peso, (come(Animal, Victima), engordaVictima(Victima,Peso)),Pesos),
	sumlist(Pesos,PesoTotal).

%3
perseguidoPorUno(Animal) :-
	perseguidoPor(Animal,Perseguidores),
	length(Perseguidores, 1).

perseguidoPor(Animal,Perseguidores) :-
	animalPerseguido(Animal),
	findall( Perseguidor, (animal(Animal),animal(Perseguidor),persigue(Perseguidor,Animal)) ,Perseguidores).

animalPerseguido(Animal) :- persigue(_,Animal).

adora(Animal, Rey):-
	noLoPersigue(Rey, Animal).
adora(Animal, Rey):-
	noLoCome(Rey, Animal).
noLoCome(Rey,Animal):-
	animal(Animal),
	animal(Rey),
	not(come(Rey,Animal)).
noLoPersigue(Rey, Animal):-
	animal(Rey),
	not(persigue(Rey, Animal)),
	Rey \= Animal.
rey(Rey) :-
	perseguidoPorUno(Rey),
	forall(animal(Animal),adora(Animal,Rey)).

/* 4
a. Polimorfismo
  En el punto 2, se usa "Victima", tanto para referirnos a un functor
  bicho, como al nombre de una animal, sin tenes que tratar cada caso
  por separado (animal o bicho)

b. Recursividad
  se usa en engordaVictima, ya que hay que saber cuanto emgorda cada una
  de las victimas del animal que estamos consultando.

c. Inversibilidad
  Se utiliza en varios predicados, con la intencion de poder realizar
  consultas para cada uno de los parametros. En algunos casos, fue
  necesario generar algunas de las variables para lograr la
  inversibilidad.
  Alguno de los predicados que son inversibles con cucarachofobico,
  jugosita, hormigofilico,  los "cuantoEngordan" del punto 2, etc

*/

sinRepetidos([X], [X]).
sinRepetidos(Lista, ListaNueva):-
	findall((member(E,Lista), member(E2, Lista)), E \= E2, ListaNueva).
















