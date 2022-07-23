# MeteoritoSpawner
class_name MeteoritoSpawner
extends Position2D

export var direccion:Vector2 = Vector2(1,1)
export var rango_tamanio_meteorito:Vector2 = Vector2(0.5, 2.2)

func _ready() -> void:
	#Esto es temporal. Como este script se llama antes del script del nivel
	#es necesario esperar a que este listo dicho script para ejecutar el envio
	#de la señal. Sin este "yield" se emite una señal que no recibe nadie
	#ya que Nivel.gd no se cargo todavia.
	yield(owner, "ready")
	spawnear_meteorito()
	
func spawnear_meteorito() -> void:
	Eventos.emit_signal(
		"spawn_meteorito", 
		global_position, 
		direccion,
		tamanio_meteorito_aleatorio()
		)
	
func tamanio_meteorito_aleatorio() -> float:
	randomize()
	return rand_range(rango_tamanio_meteorito[0], rango_tamanio_meteorito[1])
