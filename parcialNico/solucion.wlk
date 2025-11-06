import wollok.mirror.*
class Persona{
    const edad
    const emociones = []
    // var  property causaTristeza 
    method esAdolescente() = edad <= 12 && edad > 19
    method tenerNuevaEmocion(nuevaEmocion){emociones.add(nuevaEmocion)}
    method explotarEmocionalmente() = emociones.all{emocion => emocion.puedeLiberarse()}
    method vivirEvento(evento) = evento.afectarA(emociones)
}


class Emocion{
    var property intensidad  
    var property  cantidadEventos = 0 
    method condicionALiberarse()
    method puedeLiberarse() = self.condicionALiberarse() && self.intensidadElevada()   
    method intensidadElevada() = intensidad > 70
    method modificarIntensidad(cambio) {intensidad += cambio}

    method liberarse(evento){
        cantidadEventos += 1
        if(self.puedeLiberarse()){
            self.modificarIntensidad(evento.impacto())
            self.condicionEmocion(evento)
        }
    }
    method condicionEmocion(evento){}
}

class Furia inherits Emocion(intensidad = 100){
    const palabrotas = []

    method aprenderPalabrota(nuevaPalabrota) {palabrotas.add(nuevaPalabrota)}
    method olvidarPalabrota(palabrota) {palabrotas.remove(palabrota)}
    override method condicionALiberarse() = palabrotas.any{palabrota => palabrota.length() > 7}
    override method condicionEmocion(evento){
        palabrotas.remove(palabrotas.head())
    }
}

class Alegria inherits Emocion(){
    override method condicionALiberarse() = cantidadEventos % 2 == 0
    override method modificarIntensidad(valor) {
        if(intensidad < 0) intensidad = intensidad.abs() 
        else intensidad = intensidad + valor
    }
}

class Tristeza inherits Emocion(){
    var causa
    override method condicionALiberarse() = causa != "Melancolia"
    override method condicionEmocion(evento){
        causa = evento.descripcion()
    }
}


class Desagrado inherits Emocion(){}
class Temor inherits Emocion(){}

class Ansiedad inherits Emocion(){
    override method condicionALiberarse() = cantidadEventos > 3
    override method condicionEmocion(evento){
        intensidad += 10
    }
}

object evento{
    var property impacto
    const property descripcion 

    method afectarA(emociones){
        emociones.forEach{emocion => emocion.liberarse(self)}
    }

}

object grupoPersonas{
    const personas = []

    method vivirEvento(evento){
        personas.forEach{persona => persona.vivirEvento(evento)}
    }
}