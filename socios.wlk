import actividades.*
/*Agregar al modelo los socios. De cada socio se debe registrar qué actividades realizó, que pueden ser viajes o clases de gimnasia. Para cada socio se establece 
también un máximo de actividades que puede hacer.

Se debe resolver, para un socio:

si es, o no, adorador del sol. La condición es que todas actividades que realizó sirven para broncearse.
la colección de actividades esforzadas, o sea, las actividades que realizó que implican esfuerzo.
registrar que realiza una actividad. Si ya llegó al máximo de actividades que puede hacer, hay que lanzar error.*/
class Socio{
    var edad
    var idiomas = []
    var actividadesRealizadas = []
    const property maximoActividades

    method edad() = edad
    method idiomas() = idiomas 
    method actividadesRealizadas() = actividadesRealizadas 
    method esAdoradorDelSol() = self.actividadesRealizadas().all({a => a.sirveParaBroncearse()})
    method actividadesEsforzadas() = self.actividadesRealizadas().filter({c => c.implicaEsfuerzo()})
    method registrarActividad(unaActividad){
        if (self.actividadesRealizadas().size() == maximoActividades){
            self.error("El socio ha alcanzado su maximo de actividades")
        }
        self.actividadesRealizadas().add(unaActividad)
    }
    method leAtrae(unaActividad) 

}
/*si es un socio tranquilo, entonces la condición es que la actividad lleve 4 días o más.
si es un socio coherente, entonces: si es adorador del sol, entonces la actividad debe servir para broncearse, si no, debe implicar esfuerzo.
si es un socio relajado, la condición es hablar al menos uno de los idiomas que se usan en la actividad. P.ej. si un socio relajado habla español y quechua, entonces 
una actividad en español le va a atraer, una en quechua y aymará también, una en francés e italiano no.*/

class SocioTranquilo inherits Socio{
    override method leAtrae(unaActividad) = unaActividad.dias() >= 4

}
class SocioCoherente inherits Socio{
    override method leAtrae(unaActividad){
        if(self.esAdoradorDelSol()){
            return unaActividad.sirveParaBroncearse()
        }
        else{
            return unaActividad.implicaEsfuerzo()
        }
    }
     
}
class SocioRelajado inherits Socio{
    override method leAtrae(unaActividad) = unaActividad.idiomas().contains(self.idiomas().anyOne())
}