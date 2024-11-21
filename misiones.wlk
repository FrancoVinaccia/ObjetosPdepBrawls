import personajes.*

class Mision{
    const formaDePremiar = formaComun
    method copasEnJuegoFinal() = formaDePremiar.copasEnJuegoFinal(self)

    method puedeSerSueperada() = self.cumpleEstrategia() or self.destrezaSuficiente()
    method destrezaSuficiente()
    method cumpleEstrategia() 

    method esPosibleRealizar() =  self.condicionCopasNecesarias()
    method condicionCopasNecesarias()

    method realizar() {
        if (self.esPosibleRealizar()) {self.repartirCopas()}
        else {throw new Exception(message = "Misión no puede comenzar")}
    }

    method repartirCopas()

    method resultadoMisionFactor() {
        if (self.puedeSerSueperada()) {return 1}
        else {return -1}
    }
}

class MisionIndividual inherits Mision{
    const personaje
    const dificultad

    method copasEnJuego() = dificultad*2

    override method destrezaSuficiente() = personaje.destreza() > dificultad
    override method cumpleEstrategia() = personaje.tieneEstrategia()

    override method condicionCopasNecesarias() = personaje.copas() + 10

    override method repartirCopas() = personaje.repartirCopas(self.copasEnJuegoFinal()).resultadoMisionFactor()

    method cantParticipantes() = 1
}

class MisionGrupal inherits Mision{
    const participantes

    method copasEnJuego() = 50 / participantes.size()

    override method cumpleEstrategia() = self.participantesConEstrategia().size() > participantes.size() / 2
    override method destrezaSuficiente() = participantes.forEach({participante => participante.destreza() > 400})
    method participantesConEstrategia() = participantes.filter({participante => participante.tieneEstrategia()})

    override method condicionCopasNecesarias() = participantes.sum({participante => participante.copas()}) > 60

    method cantParticipantes() = participantes.size()
}

object formaComun{
    method copasEnJuegoFinal(mision) = mision.copasEnJuego()
}

object formaBonus {
  method copasEnJuegoFinal(mision) = mision.copasEnJuego() + mision.cantParticipantes()
}

class FormaBoost {
  const multiplicador
  method copasEnJuegoFinal(mision) = mision.copasEnJuego() * multiplicador
}