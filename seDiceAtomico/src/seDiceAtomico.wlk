object region{
	var ciudades = [springfield,albuquerque]
	method centralCiudadMasProductiva(){ //map max (max of list of lists)
		return  ciudades.map{ciudad => ciudad.centralMasProductiva()}
	}
}	
object springfield {
	var velocidadViento = 10
	var riquezaSuelo = 0.9
	var centrales = [burns,exBosque,elSuspiro]
	var necesidadCentral
	method velocidadViento() {
		return velocidadViento
	}
	method riquezaSuelo() {
		return riquezaSuelo
	}
	method necesidad(necesidad){
		necesidadCentral = necesidad
	}
	method centralesContaminantes() {
		return centrales.filter ({central => 
			central.contaminacion()})
	}
	method cubreNecesidad() {
		return self.produccionCentrales() > necesidadCentral
	}
	method produccionCentrales(){
		return centrales.sum {central => 
			central.produccionEnergetica()}
	}
	method estaAlHorno() {
		return self.produccionCentrales() > necesidadCentral * 0.5 
		or self.todasCentralesContaminantes()
	}
	method todasCentralesContaminantes() {
		return self.centralesContaminantes() == centrales
	}
	method centralMasProductiva(){
		return centrales.max{central => central.produccionEnergetica()}
	}
}

object burns {
	var varillasDeUranio
	method varillas(cantidadVarillas){
		varillasDeUranio = cantidadVarillas
	}
	method cantidadDeVarillas() {
		return varillasDeUranio
	}
	method produccionEnergetica() {
		return 0.1 * varillasDeUranio
	}
	method contaminacion() {
		return self.cantidadDeVarillas() > 20
	}
	//method contaminacion() {
	//	return varillasDeUranio > 20
	//}
}

object exBosque {
	var ciudad = springfield
	var capacidadCentral
	method capacidad(capacidad){
		capacidadCentral = capacidad
	}
	/*method produccionEnergetica(ciudad) {
		return 0.5 + capacidad * self.riquezaSuelo(ciudad)
	}*/
	method riquezaSuelo() {
		return ciudad.riquezaSuelo()
	}
	method produccionEnergetica() {
		return 0.5 + capacidadCentral * ciudad.riquezaSuelo()
	}
	method contaminacion() {
		return true
	}
}

object elSuspiro {
	var turbinas = [turbina1]
	var ciudad = springfield
	method instalarTurbinas(turbina) {
		return turbinas.add(turbina)
	}
	/* method produccionEnergetica () {
		return turbinas.sum(turbinas)
	} */
	method produccionEnergetica() {
		return turbinas.sum({turbina => turbina.produccionEnergetica(ciudad)})
	}
	method contaminacion() {
		return false
	}
}
object turbina1 {
	/* method produccionEnergetica() {
		return 0.2 * springfield.velocidadViento()
	} */
	method produccionEnergetica (ciudad) {
		return 0.2 * ciudad.velocidadViento()
	}
}
object albuquerque {
	var caudalRio = 150
	var centrales = [hidroelectrica]
	method caudalRio(){
		return caudalRio
	}
	method centralMasProductiva(){
		return centrales.max{central => central.produccionEnergetica()}
	}
}
object hidroelectrica {
	var ciudad = albuquerque
	method produccionEnergetica() {
		return 2 * ciudad.caudalRio()
	}
}