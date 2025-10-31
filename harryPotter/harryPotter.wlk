class CriaturaMagica{
 var property  salud = 100
 method recibirDanio(cantidad) {salud -= cantidad}
}
class Estudiante{
  var property salud = 100
  var property casa
  var property habilidad 
  var property hechizos = []
  var property materias = [] 
  const property sangrePura

  method esPeligroso() = salud > 0 && casa.esPeligroso(self)
  method cambiarCasa(nuevaCasa) {casa = nuevaCasa}

  method tomarClase(hechizo){
    habilidad+=1
    hechizos.add(hechizo)
  }
  method inscribirmeEn(materia) {
  materias.add(materia)
  materia.inscribirEstudiante(self)  
}

  method darmeDeBaja(materia) {
  materias.remove(materia)
  materia.darDeBajaEstudiante(self)  
}

  method recibirDanio(cantidad) {salud -= cantidad}
  method disminuirHabilidad(cantidad) {habilidad -= cantidad}

  method hacerHechizo(hechizo, destinatario) {
  if (!hechizos.contains(hechizo)) 
    self.error("No aprendí ese hechizo")
  
  if (!hechizo.puedeSerLanzadoPor(self))
    self.error("No cumplo las condiciones para lanzar este hechizo")
    
  hechizo.aplicarEfectos(self, destinatario)
}
}

object gryffindor {
  method esPeligroso(estudiante) = false
}

object slytherin {
  method esPeligroso(estudiante) = true
}

object ravenclaw {
  method esPeligroso(estudiante) = estudiante.habilidad() > 10
}

object hufflepuff {
  method esPeligroso(estudiante) = estudiante.sangrePura()
}

//==============================================================================//

class Materia{
  var property hechizo
  const profesor
  var estudiantes = []
  method cambiarHechizo(nuevoHechizo) {hechizo = nuevoHechizo}

  method dictarClases() {estudiantes.forEach{e => e.tomarClase(hechizo)}}

  method inscribirEstudiante(estudiante) {estudiantes.add(estudiante)}
  method darDeBajaEstudiante(estudiante){estudiantes.remove(estudiante)}
  method practicarHechizo(criatura) = estudiantes.forEach{e => e.hacerHechizo(hechizo, criatura)} 
}


class HechizoComun {
  const nivelDificultad

  method puedeSerLanzadoPor(estudiante)  = nivelDificultad <= estudiante.habilidad()
  method afectarDestinatario(destinatario) {destinatario.recibirDanio(nivelDificultad + 10)}
  method afectarLanzador(estudiante) {}

  method aplicarEfectos(estudiante, destinatario) {  
    self.afectarDestinatario(destinatario)
    self.afectarLanzador(estudiante)
  }
}

//class HechizoComun inherits Hechizo{
//}

class HechizoImperdonable inherits HechizoComun{
    const dañoLanzador

    override method afectarDestinatario(destinatario){destinatario.recibirDanio((nivelDificultad + 10)*2)}
    override method afectarLanzador(estudiante) {estudiante.recibirDanio(dañoLanzador)}
}

class HechizoImposible inherits HechizoComun{
  override method afectarLanzador(estudiante){estudiante.disminuirHabilidad(1)}
  override method puedeSerLanzadoPor(estudiante) = !estudiante.esPeligroso()
}

const pepe = new Estudiante(casa = gryffindor, habilidad = 10, sangrePura = false)

const immobilus = new HechizoComun(nivelDificultad = 5)
const expelliarmus = new HechizoComun(nivelDificultad = 8)
const stupefy = new HechizoComun(nivelDificultad = 10)
const protego = new HechizoComun(nivelDificultad = 7)
const cruciatus = new HechizoImperdonable(nivelDificultad = 15, dañoLanzador = 20)
const imperius = new HechizoImperdonable(nivelDificultad = 18, dañoLanzador = 25)
const avadakedabra = new HechizoImperdonable(nivelDificultad = 20, dañoLanzador = 30)
const sectumSempra = new HechizoImposible(nivelDificultad = 12)

const defensaContraLasArtesOscuras = new Materia(
  profesor = "Severus",
  hechizo = immobilus
)

const lechuza = new CriaturaMagica()
const basilisco = new CriaturaMagica()

const harryPotter = new Estudiante(
  casa = gryffindor, 
  habilidad = 12, 
  sangrePura = false
)

const hermioneGranger = new Estudiante(
  casa = gryffindor, 
  habilidad = 15, 
  sangrePura = false
)

const dracoMalfoy = new Estudiante(
  casa = slytherin, 
  habilidad = 4, 
  sangrePura = true
)

const ronWeasley = new Estudiante(
  casa = gryffindor, 
  habilidad = 10, 
  sangrePura = false
)
