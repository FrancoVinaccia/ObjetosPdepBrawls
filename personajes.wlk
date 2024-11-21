import misiones.*

class Personaje{
  var property copas

  method repartirCopas(cant){copas += cant} 
  method destreza()
}

class Arquero inherits Personaje{
  const agilidad
  const rango

  override method destreza() = agilidad * rango
  method tieneEstrategia() = rango > 100
}

class Guerrera inherits Personaje{
  const fuerza
  const tieneEstrategia

  override method destreza() = fuerza * 1.5
  method tieneEstrategia() = tieneEstrategia
}

class Ballestero inherits Arquero{
  override method destreza() = super() * 2
}