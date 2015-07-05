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
persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).
persigue(scar, mufasa).
animal(mufasa).
animal(scar).
animal(timon).
animal(pumba).
animal(shenzi).
animal(simba).
animal(banzai).

cucaracha(NombreCucaracha,TamanioCucaracha,PesoCucaracha):-
	 comio(_,cucaracha(NombreCucaracha,TamanioCucaracha,PesoCucaracha)).

hormiga(NombreHormiga):-
	comio(_,hormiga(NombreHormiga)).

vaquitaSanAntonio(NombreVaquita,PesoVaquita):-
	 comio(_,vaquitaSanAntonio(NombreVaquita,PesoVaquita)).
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
	findall(NombreHormiga, comio(Personaje,hormiga(NombreHormiga)),Hormigas).


comioMasDeDosHormigas(Hormigas):-
	length(Hormigas, CantidadHormigas),
	CantidadHormigas >= 2.

 /*Ver de filtrar los resultados*/


%c)
cucarachofobico(Personaje):-
	comio(Personaje,_),
	not(comio(Personaje,cucaracha(_,_,_))).
/*Ver de filtrar los resultados*/


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

%2) a)

cuantoEngorda(Personaje, Peso):-
        comio(Personaje,_),
	pesosDeBichosQueComio(Personaje, Peso).

/*Ver que cuantoEngorda,  traigan resultados filtrados */


pesosDeBichosQueComio(Personaje, 0):-
	not(bichoQueComio(Personaje,_)).

pesosDeBichosQueComio(Personaje, Peso):-
	findall(PesoBicho, bichoQueComio(Personaje, PesoBicho), PesosBichos),
	sumlist(PesosBichos, Peso).


bichoQueComio(Personaje, PesoBicho):-
	comio(Personaje,cucaracha(_,_,PesoBicho)).

bichoQueComio(Personaje, PesoBicho):-
	comio(Personaje,vaquitaSanAntonio(_,PesoBicho)).

bichoQueComio(Personaje, PesoBicho):-
	comio(Personaje,hormiga(_)),
	pesoHormiga(PesoBicho).


cuantoEngordaPersecusor(Personaje, Peso):-
	pesoDeLasPrezasQuePersiguio(Personaje, PesoPrezas),
	pesosDeBichosQueComio(Personaje, PesoBicho),
	Peso is PesoPrezas + PesoBicho.

pesoDeLasPrezasQuePersiguio(Personaje, 0):-
	not(persigue(Personaje,_)).

pesoDeLasPrezasQuePersiguio(Personaje, PesoPrezas):-
	findall(PesoPreza, (persigue(Personaje, Preza),peso(Preza, PesoPreza)),ListaPesoPrezas),
	sumlist(ListaPesoPrezas, PesoPrezas).


/*Ver que cuanto engorda final haga bien las cuentas*/



cuantoEngordaFinal(Personaje,Peso):-
	pesoFinalDeLasPrezasQuePersiguio(Personaje, PesoPrezas),
	pesosDeBichosQueComio(Personaje, PesoBicho),
	Peso is PesoPrezas + PesoBicho.

pesoFinalDeLasPrezasQuePersiguio(Personaje, PesoPrezas):-
	findall(PesoFinalPreza, (persigue(Personaje, Preza),pesoPrezaDespuesDeComer(Preza,PesoFinalPreza)),ListaPesoPrezas),
	sumlist(ListaPesoPrezas, PesoPrezas).

pesoPrezaDespuesDeComer(Preza,PesoFinalPreza):-
	cuantoEngorda(Preza, Peso),
	peso(Preza, PesoPreza),
	PesoFinalPreza is PesoPreza + Peso.


%3



loPersigueSoloUno(Rey):-
        animal(Rey),
	findall(Persecusor, persigue(Persecusor, Rey), Persecusores),
	length(Persecusores, 1).
/*OK */

adora(Animal, Rey):-
	noLoPersigue(Rey, Animal).

adora(Animal, Rey):-
	noLoCome(Rey, Animal).

noLoCome(Rey,Animal):-
	not(come(Rey,Animal)).
come(Rey, Animal):-
	persigue(Rey, Animal).

noLoPersigue(Rey, Animal):-
	animal(Rey),
	not(persigue(Rey, Animal)),
	Rey \= Animal.



todosLoAdoran(Rey):-
	animal(Animal),
	animal(Rey),
	forall((animal(Animal)), adora(Animal, Rey)).

rey(Rey):-
	loPersigueSoloUno(Rey),
	todosLoAdoran(Rey).
/*Aparece mas de 1 resultado
debe aparecer solo mufasa

elRey(Animal) :-
     todosLoAdoran(Animal),
     esPerseguidoPorLista(Animal,[Persecusor]).
*/
