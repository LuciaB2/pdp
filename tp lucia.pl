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


/*Enunciado
Viscosos pero Sabrosos
En la jungla tan imponente el le�n rey duerme ya... Y Tim�n y Pumba
salieron a lastrar bichos.
Tenemos tres tipos de bichos, representados por functores: las
vaquitas de San Antonio (de quienes nos interesa un peso), las
cucarachas (de quienes nos interesa un tama�o y un peso) y las
hormigas, que pesan siempre lo mismo. De los personajes tambi�n se
conoce el peso, mediante hechos.
La base de conocimiento es la que sigue:
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
pesoHormiga(2).
%peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).
1) A falta de pochoclos�
UTN FRBA - Paradigmas de Programaci�n - Prof. Lucas Spigariol
Parcial de L�gico - Viscosos Pero Sabrosos - Lunes 04/10/2010
Definir los predicados que permitan saber:
a) Qu� cucaracha es jugosita: � sea, hay otra con su mismo tama�o pero ella es m�s gordita.
?- jugosita(cucaracha(gimeno,12,8)).
Yes
b) Si un personaje es hormigof�lico... (Comi� al menos dos hormigas).
?- hormigofilico(X).
X = pumba;
X = simba.
c) Si un personaje es cucarachof�bico (no comi� cucarachas).
?- cucarachofobico(X).
X = simba
d) Conocer al conjunto de los picarones. Un personaje es picar�n si comi� una cucaracha jugosita � si se
come a Remeditos la vaquita. Adem�s, pumba es picar�n de por s�.
?- picarones(L).
L = [pumba, timon, simba]
2) Pero yo quiero carne�
Aparece en escena el malvado Scar, que persigue a algunos de nuestros amigos. Y a su vez, las hienas Shenzi
y Banzai tambi�n se divierten...
persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon)
Por ejemplo, un d�a hab�a una hiena distraida y con mucho
hambre y amplio su dieta
comio(shenzi,hormiga(conCaraDeSimba)).
Completando la base...
peso(scar, 300).
peso(shenzi, 400).
peso(banzai, 500).
a) Se quiere saber cu�nto engorda un personaje (sabiendo que engorda una cantidad igual a la suma de
los pesos de todos los bichos en su men�). Los bichos no engordan.
?- cuantoEngorda(Personaje, Peso).
Personaje= pumba
Peso = 83;
Personaje= timon
Peso = 17;
UTN FRBA - Paradigmas de Programaci�n - Prof. Lucas Spigariol
Parcial de L�gico - Viscosos Pero Sabrosos - Lunes 04/10/2010
Personaje= simba
Peso = 10
b) Pero como indica la ley de la selva, cuando un personaje persigue a otro, se lo termina comiendo, y por lo
tanto tambi�n engorda. Realizar una nueva version del predicado cuantoEngorda.
?- cuantoEngorda(scar,Peso).
Peso = 150
(es la suma de lo que pesan pumba y timon)
?- cuantoEngorda(shenzi,Peso).
Peso = 502
(es la suma del peso de scar y simba, mas 2 que pesa la hormiga)
c) Ahora se complica el asunto, porque en realidad cada animal antes de comerse a sus v�ctimas espera a que
estas se alimenten. De esta manera, lo que engorda un animal no es s�lo el peso original de sus v�ctimas, sino
tambi�n hay que tener en cuenta lo que �stas comieron y por lo tanto engordaron. Hacer una �ltima version del
predicado.
?- cuantoEngorda(scar,Peso).
Peso = 250
(150, que era la suma de lo que pesan pumba y timon, m�s 83 que se come
pumba y 17 que come timon )
?- cuantoEngorda(shenzi,Peso).
Peso = 762
(502 era la suma del peso de scar y simba, mas 2 de la hormiga. A eso se
le suman los 250 de todo lo que engorda scar y 10 que engorda simba)
3) Buscando el rey�
Sabiendo que todo animal adora a todo lo que no se lo come o no lo
persigue, encontrar al rey. El rey es el animal a quien s�lo hay un animal
que lo persigue y todos adoran.
Si se agrega el hecho:
persigue(scar, mufasa).
?- rey(R).
R = mufasa.
(s�lo lo persigue scar y todos los adoran)
4) Explicar en d�nde se usaron y c�mo fueron de utilidad los siguientes
conceptos:
a. Polimorfismo
b. Recursividad
c. Inversibilidad

*/
