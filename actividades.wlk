/*idiomas que se usan durante el viaje.
si hacer el viaje implica esfuerzo o no.
si el viaje sirve para broncearse o no.
cuántos días lleva la actividad.*/
import socios.*
class Actividades{
    const property idiomas = []
     
    method dias() 
    method sirveParaBroncearse() = true
    method implicaEsfuerzo()  
    method esInteresante() = self.idiomas().size() > 1
    method esRecomendadaParaSocio(unSocio) = self.esInteresante() and unSocio.leAtrae(self) and not unSocio.actividadesRealizadas().contains(self)
}
/*Viajes de playa.
De cada viaje de playa se informa el largo de la playa, medido en metros. Para calcular cuántos días lleva un viaje de playa, se hace esta cuenta: 
largo / 500. Un viaje de playa implica esfuerzo si el largo de la playa supera los 1200 metros. Todos los viajes de playa sirven para broncearse.*/

class ViajePlaya inherits Actividades{
    const property largo

    override method dias() =  self.largo() / 500
    override method implicaEsfuerzo() = self.largo() > 1200
    //override method sirveParaBroncearse() = true  
}

/*De cada excursión a ciudad se informa cuántas atracciones se van a visitar. Los días que lleva un viaje de este tipo se calculan como cantidad de 
atracciones / 2. Una excursión implica esfuerzo si se visitan entre 5 y 8 atracciones, y nunca sirve para broncearse.

Un caso especial son las excursiones a ciudad tropical. Son como las excursiones a ciudad, con las siguientes variantes:
 dura un día más que una excursión a ciudad de las mismas características, y sí sirve para broncearse, siempre.*/
class ExcursionCiudad inherits Actividades{
    var atracciones

    override method esInteresante() = super() or self.atracciones() == 5
    method atracciones() = atracciones 
    override method dias() =  self.atracciones() / 2
    override method implicaEsfuerzo() = self.atracciones().between(5, 8)
    override method sirveParaBroncearse() = false  
}
class ExcursionCiudadTropical inherits ExcursionCiudad{
    override method dias() = super() +1
    override method sirveParaBroncearse() = true 

}

/*De cada salida de trekking se conoce cuántos kilómetros de senderos se van a recorrer caminando, y cuántos días de sol por año tiene el lugar donde se va a hacer.
Los días que lleva una salida se calculan como kilometros de senderos / 50. Una salida implica esfuerzo si se recorren más de 80 kilómetros, y sirve para broncearse 
si en el lugar hay más de 200 días de sol por año, o hay entre 100 y 200, y se recorren más de 120 kilómetros.*/

class SalidaTrekking inherits Actividades{
    const property kmSendero
    const property diasSol

    override method esInteresante() = super() and self.diasSol() > 140
    override method dias() =  self.kmSendero() / 50
    override method implicaEsfuerzo() = self.kmSendero() > 80
    override method sirveParaBroncearse() = (self.diasSol() > 200) or (self.diasSol().between(100, 200) and self.kmSendero() > 120)  
}

/*Agregar al modelo la capacidad de preguntar si un viaje es interesante. Por lo general, la condición es que se use más de un idioma, p.ej. quechua y aymara, o francés, alemán y húngaro. 
Hay que contemplar estas variantes:

las excursiones a ciudad (tropical o no) se consideran interesantes si se cumple la condición general, o bien, se recorren exactamente 5 atracciones (ni más ni menos, exactamente 5).
las salidas de trekking se consideran interesantes si se cumple la condición general, y además en el lugar hay más de 140 días de sol por año.*/

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*Agregar al modelo las clases de gimnasia, que son otro tipo de actividad que la mutual ofrece a sus socios.

Se deben resolver las mismas cuatro preguntas que para los viajes, que se responden así:

idiomas: en las clases de gimnasia se usa únicamente español.
Llevan 1 día.
Siempre implican esfuerzo, y nunca sirven para broncearse.*/
class ClaseGimnasia inherits Actividades{
    method initialize(){
        idiomas.clear()
        idiomas.add("Español")
    }
    override method dias() = 1 
    override method implicaEsfuerzo() = true
    override method sirveParaBroncearse() = false  
    override method esRecomendadaParaSocio(unSocio) = unSocio.edad().between(20, 30)
}
/*Agregar un nuevo tipo de actividad: el taller literario. De cada taller se registra sobre qué libros se trabaja. De cada libro se conoce: el idioma, la cantidad de páginas,
 y el nombre del autor.

Para un taller literario tenemos:

idiomas usados: los de los libros que se trabajan.
días que lleva: la cantidad de libros más uno.
implica esfuerzo: si incluye al menos un libro de más de 500 páginas, o bien todos los libros son del mismo autor, y hay más de uno.
sirve para broncearse: nunca.
es recomendado para un socio: la condición es que el socio hable más de un idioma.*/


class TallerLiterario inherits Actividades{
    var libros = []

    method libros() = libros 
    override method dias() = self.libros().size() +1 
    override method implicaEsfuerzo() = self.libros().any({c => c.cantPaginas()>500}) or self.libros().all({c => c.nombreAutor()}) 
    override method sirveParaBroncearse() = false
    override method esRecomendadaParaSocio(unSocio) = unSocio.idiomas().size() > 1  
} 
class Libros{
    const property idioma 
    const property cantPaginas 
    const property nombreAutor 

}