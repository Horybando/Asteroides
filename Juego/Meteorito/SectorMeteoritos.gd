#SectorMeteoritos.gd
class_name SectorMeteoritos
extends Node2D

## Atributos export
export var cantidad_meteoritos:int = 10
export var intervalo_spawn:float = 1.0

## Atributos
var spawners:Array

## Constructor
func crear(pos: Vector2, meteoritos: int) -> void:
	global_position = pos
	cantidad_meteoritos = meteoritos
	
##Metodos
func _ready() -> void:
	$SpawnTimer.wait_time = intervalo_spawn
	almacenar_spawners()
	conectar_seniales_detectores()
	

## Metodos custom
func conectar_seniales_detectores() -> void:
	for detector in $DetectorFueraZona.get_children():
		detector.connect("body_entered", self, "_on_detector_body_entered")
		
func almacenar_spawners() -> void:
	for spawner in $Spawners.get_children():
		spawners.append(spawner)
		
func spawner_aleatorio() -> int:
	randomize()
	return randi() % spawners.size()
	
## Señales internas
func _on_detector_body_entered(body: Node) -> void:
	body.set_esta_en_sector(false)

func _on_SpawnTimer_timeout() -> void:
	if cantidad_meteoritos == 0:
		$SpawnTimer.stop()
		return
		
	spawners[spawner_aleatorio()].spawnear_meteorito()
	cantidad_meteoritos -= 1
