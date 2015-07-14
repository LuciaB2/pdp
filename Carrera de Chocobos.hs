{-ENUNCIADO
Las carreras de chocobos son un entretenimiento cada día más popular, y por lo tanto ya es hora de armar un programa que nos ayude a analizarlas como es debido. Elegimos hacerlo en Haskell, básicamente por inercia (y... ya que lo venimos usando hace 2 meses, sigamos con eso).
Las pistas por las que nuestros emplumados amigos deben correr van a estar representadas por listas de tramos, cada tramo a su vez será representado por una tupla (distancia, correcciónDeVelocidad).
bosqueTenebroso =
[(100, f1), (50, f2), (120, f2), (200, f1), (80, f3)]
pantanoDelDestino =
[(40, f2), (90, (\(f,p,v)-> f + p + v)), (120, fuerza), (20, fuerza)]
f1 chocobo = velocidad chocobo * 2
f2 chocobo = velocidad chocobo + fuerza chocobo
f3 chocobo = velocidad chocobo / peso chocobo
Tenemos los chocobos (esenciales para una carrera de chocobos): el amarillo, el negro, el blanco y el rojo. Cada uno tiene distintas características, modeladas por medio de una tupla (fuerza, peso, velocidad).
amarillo = (5, 3, 3)
negro = (4, 4, 4)
blanco = (2, 3, 6)
rojo = (3, 3, 4)
Así mismo, están las funciones de acceso a la tupla:
fuerza (f,_,_) = f
peso (_,p,_) = p
velocidad (_,_,v) = v
Finalmente, estos chocobos están dirigidos por los 4 jinetes:
apocalipsis = [(“Leo”, amarillo), (“Gise”, blanco), (“Mati”, negro), (“Alf”,rojo)]
Disponemos de esta función a modo de ayuda que, a partir de una lista y un criterio de ordenamiento, nos devuelve la versión equivalente a esa lista pero con los elementos ordenados por el criterio dado.
quickSort _ [] = []
quickSort criterio (x:xs) =
(quickSort criterio . filter (not . criterio x)) xs
++ [x] ++
(quickSort criterio . filter (criterio x)) xs
Ejemplo de uso:
> quickSort (>) [3,8,7,20,2,1]
[20,8,7,3,2,1]
Notas:
Deberán utilizar correctamente al menos una vez cada uno de las siguientes conceptos:
 Orden superior
 Listas por comprensión
 Composición
 Aplicación parcial
No se pueden definir funciones recursivas en más de un punto de los desarrollados.
Paradigmas de Programación Paradigma Funcional 26/05/2012
Página 2 de 2
Se pide desarrollar las siguientes funciones:
1. Definir dos funciones mayorSegun y menorSegun que, dados una función y dos valores, nos dice si el resultado de
evaluar la función para el primer valor es mayor / menor que el resultado de evaluar la función para el segundo.
> mayorSegun length bosqueTenebroso pantanoDelDestino
True (tiene 5 tramos el bosque y 4 tramos el pantano)
2.
a. Saber el tiempo que tarda un chocobo en recorrer un tramo. El mismo está dado por la distancia del tramo
dividido por la velocidad corregida para el chocobo.
> tiempo amarillo (head bosqueTenebroso)
16
b. Determinar el tiempo total de un chocobo en una carrera.
> tiempoTotal bosqueTenebroso amarillo
150
3. Obtener el podio de una carrera, representado por una lista ordenada de los 3 primeros puestos de la misma, en
base a una lista de jinetes y una pista. El puesto está dado por el tiempo total, de menor a mayor y se espera
obtener una lista de jinetes.
> podio bosqueTenebroso apocalipsis
[("Gise",(2,3,6)),("Mati",(4,4,4)),("Alf",(3,3,4))] (ver también ejemplo del punto 6)
4.
a. Realizar una función que dado un tramo y una lista de jinetes, retorna el nombre de aquel que lo recorrió en
el menor tiempo.
> elMejorDelTramo (head bosqueTenebroso) apocalipsis
"Gise" (Gise tarda 8, mientras que Leo tarda 16 y Mati y Alf tardan 12)
b. Dada una pista y una lista de jinetes, saber el nombre del jinete que ganó más tramos (que no quiere decir
que haya ganado la carrera).
> elMasWinner pantanoDelDestino apocalipsis
"Leo" (gana 2 tramos, el resto gana 1 o ninguno)
5. Saber los nombres de los jinetes que pueden hacer un tramo dado en un tiempo indicado máximo..
> quienesPueden (head bosqueTenebroso) 12 apocalipsis
["Gise","Mati","Alf"] (ver 4.a)
6. Obtener las estadísticas de una carrera, dada la pista y la lista de jinetes. Estas estadísticas deben estar
representadas por una lista de tuplas, cada tupla siendo de la forma: (nombre, tramosGanados, tiempoTotal)
> estadisticas bosqueTenebroso apocalipsis
[("Leo",0,150),("Gise",3,85),("Mati",2,138),("Alf",0,141)]
7. Saber si una carrera fue pareja. Esto es así si cada chocobo tuvo un tiempo total de hasta 10% menor que el que
llegó a continuación.
> fuePareja bosqueTenebroso apocalipsis
False (entre Gise y Mati, 1ª y 2º respectivamente, hay más de 10% de diferencia)
8. Definir un chocobo plateado que tenga las mejores características de los otros (mayor fuerza, menor peso, mayor
velocidad), teniendo en cuenta que no sea necesario cambiar su definición si se altera un valor de los
anteriores.
> plateado
(5,3,6)
9. Definir el tipo de funcionHeavy:
funcionHeavy x y z
| (fst . head) x < snd y = map z x
| otherwise = filter (fst y ==) (map z x)
-}
--Tramo = (Distancia, CorreccionDeVelocidad)
type Pista = [Tramo]
type Distancia = Int
type Tramo = (Distancia, CorreccionDeVelocidad)
bosqueTenebroso = [(100, f1), (50, f2), (120, f2), (200, f1), (80, f3)]
pantanoDelDestino = [(40, f2), (90, (\(f,p,v)-> f + p + v)), (120, fuerza), (20, fuerza)]

--CorreccionDeVelocidad
type CorreccionDeVelocidad = Chocobo -> Float
f1 chocobo = velocidad chocobo * 2
f2 chocobo = velocidad chocobo + fuerza chocobo
f3 chocobo = velocidad chocobo / peso chocobo


--chocobo = (Fuerza, Peso, Velocidad)
type Chocobo = (Fuerza, Peso, Velocidad)
type Fuerza = Chocobo -> Int
type Peso = Chocobo -> Int
type Velocidad = Chocobo -> Int

amarillo = (5, 3, 3)
negro = (4, 4, 4)
blanco = (2, 3, 6)
rojo = (3, 3, 4)

fuerza (f,_,_) = f
peso (_,p,_) = p
velocidad (_,_,v) = v

--jinetes = [(NombreJinite, Chocobo)]
type Jinetes = [Jinete]
type Jinete = (NombreJinete, Chocobo)
type NombreJinete = String
apocalipsis = [("Leo", amarillo), ("Gise", blanco), ("Mati", negro), ("Alf",rojo)]

--ordenxcriterio
type QuickSort = (a->a) --> [a] -> [a]
quickSort _ [] = []
quickSort criterio (x:xs) =
	(quickSort criterio . filter (not . criterio x)) xs
	++ [x] ++
	(quickSort criterio . filter (criterio x)) xs

--1
type MayorSegun = (A->A) -> A -> A -> Bool	{-cuando compilo  el winghci no toma a "A" o "a" como tipo de dato  
											("Carrera de Chocobos.hs:48:23: Not in scope: type constructor or class `A' ") -}
mayorSegun funcion valor1 valor2 = (funcion valor1) >  (funcion valor2)
type MenorSegun = (A->A) -> A -> A -> Bool
menorSegun funcion valor1 valor2 = (funcion valor1) <  (funcion valor2)


--2
type Tiempo = Chocobo -> Tramo -> Int
tiempo chocobo (distancia, correccionDeVelocidad) =  div distancia correccionDeVelocidad

type TiempoTotal = Chocobo -> Pista  -> Int
tiempoTotal chocobo pista  = sum (tiemposPorTramo chocobo  pista)
	where tiemposPorTramo chocobo pista  = map (tiempo chocobo) pista	    {-Por point free se eliminaria pista-}  {-funciona si hago map.tiempo?-}

--3	
type Podio = Pista -> Jinetes -> Jinetes
podio pista jinetes = primerosTres pista jinetes
	where primerosTres = take 3 puestosJinetes
	      puestosJinetes = quickSort (>) resultadosCarrera 
		  resultadosCarrera = map (tiempoTotal pista) chocobosQueCorre 
		  chocobosQueCorre = map snd jinetes
{-no se si eta bien.
ademas:
Carrera de Chocobos.hs:65:37: parse error on input `='
a causa de esto no puedo saber si funciona bien el resto de lo realizado ya que, aunque comente la linea, hay otra que tiene el mismo error 
(y no me doy cuanta que es exactamente lo que esta mal para que aparezca este error)		-}		  

--4
type ElMejorDelTRamo = Tramo -> Jinetes -> NombreJinete
elMejorDelTramo tramo jinetes =  maximoJinete  tramo jinetes
	where maxinoJinete tramo jinete = [nombreJinete| (nombreJinete, chocobo) <- Jinetes, maxChocobo chocobos tramo]
			{-la idea es que devuelva un solo nombreJinete -}
		  maxChocobo chocobos tramo = [chocobo | (chocobo <- chocobos, chocobo2 <- chocobos), chocoboQueMenosTardo chocobo chocobo2 tramo]
		  {-la idea es que devuelva un solo choccbo que despue slo asocio al jinete -}
		  chocoboQuetardoMenos chocobo chocobo2  tramo = min (tiempo chocobo tramo) (tiempo chocobo2 tramo) 
  
{-ok?-}
type ElMasWinner = Pista -> Jinetes -> NombreJinete
elMasWinner pista jinetes =  ganoMasTramos pista  jinetes
	where ganoMasTramos pista jinetes  =  [ nombreJinete | (nombreJinete, Chocobo) <- jinetes, (nombreJinete2, chocobo2) <- jinetes),  (cantidadTramosQueGano jinete pista) > (cantidadTramosQueGano jinete pista)] 
	{-la idea es que devuelva un solo nombreJinete -}
		  
type CantidadTramosGanados = Jinete -> Pista -> Int		  
cantidadTramosQueGano jinete pista = length (tramosQueGano jinete pista)
	where tramosQueGano jinete pista = filter (tramoGanado jinete) pista
		  tramoGanado (nombreJinete, chocobo) tramo = elMejorDelTramo tramo (nombreJinete, chocobo) == nombreJinete
		  
--6
type Estadisticas = Pista -> Jinetes -> (NombreJinete, Int, Int )
estadisticas pista jinetes = map ( resultadoPorJinete pista)  jinetes
	where resultadoPorJinete pista (nombreJinete, chocobo) = (nombreJinete, cantidadTramosQueGano (nombreJinete, choccbo) pista, tiempoTotal choccbo pista )
	
--5
type QuienesPueden = Tramo -> Int -> Jinetes -> [NombreJinete]
quienesPueden tramo tiempoMaximo jinetes =  [nombreJinete| (nombreJinete, chocobo)<- jinetes, (tiempo chocobo  tramo)<  tiempoMaximo]

--7
type FuePareja = Pista -> Jinetes -> Bool
fuePareja pista jinetes =  foldl1 estanParejos dosPrimeros
	where dosPrimeros = take 2  (podio pista jinetes )
	      (tiempoTotal chocobo1 pista) >=  0.10 * (tiempoTotal chocobo2 pista) 
{-en el ultimo where se podria simplificar de alguna forma?-}

		  
--8 
type Chocobos = [Chocobo]
chocobos = [amarillo, negro, blanco, rojo]
plateado =  (maximaFuerza chocobos, menorPeso chocobos, mayorVelocidad chocobos)
	where  maximaFuerza chocobos = maxium (map.fuerza chocobos)
	       minimoPeso chocobos = minium (map.peso chocobos)
		   mayrVelocidad chocobos = maxium (map.velocidad chocobos)

{-en este where se podria haber hecho
	maxium.map.fst chocobos  y asi por poit free eliminamos chocobos???-}

--9	
type funcionHeavy = [(a,b)] -> (c,a) -> (a -> c )  -> c	  

		  