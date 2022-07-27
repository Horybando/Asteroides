#Meteorito.gd
class_name Meteorito
extends RigidBody2D

## Atributos export

export var vel_lineal_base:Vector2 = Vector2(300.0, 300.0)
export var vel_ang_base:float = 3.0
export var hitpoints_base:float = 10.0

# Atributos
var hitpoints:float
var esta_en_sector:bool = true setget set_esta_en_sector
var pos_spawn_original:Vector2
var vel_spawn_original:Vector2
var esta_destruido:bool = false

## Atributos onredy
onready var impacto_sfx:AudioStreamPlayer = $ImpactosSFX
onready var impactos:AnimationPlayer = $Impactos

## Setter y Getter
func set_esta_en_sector(valor: bool) -> void:
	esta_en_sector = valor
	
## Constructor
func crear(pos: Vector2, dir: Vector2, tamanio: float) -> void:
	position = pos
	#Calcular masa, tamaño de sprite y de colisionador
	mass *= tamanio
	$Sprite.scale = Vector2.ONE * tamanio
	var radio:int = int($Sprite.texture.get_size().x / 2 * tamanio)
	var forma_colision:CircleShape2D = CircleShape2D.new()
	forma_colision.radius = radio
	$CollisionShape2D.shape = forma_colision
	#Calcular velocidades
	linear_velocity = (vel_lineal_base * dir / tamanio) * aleatorizar_velocidad()
	vel_spawn_original = linear_velocity
	angular_velocity = (vel_ang_base / tamanio) * aleatorizar_velocidad()
	#Calcular hitpoints
	hitpoints = hitpoints_base * tamanio

## Métodos
func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if esta_en_sector:
		return
		
	var mi_tranform := state.get_transform()
	mi_tranform.origin = pos_spawn_original
	linear_velocity = vel_spawn_original
	state.set_transform(mi_tranform)
	esta_en_sector = true
		
## Metodos custom
func aleatorizar_velocidad() -> float:
	randomize()
	return rand_range(1.1, 1.4)


func recibir_danio(danio: float) -> void:
	hitpoints -= danio
	if hitpoints <= 0 and not esta_destruido:
		esta_destruido = true
		destruir()
	
	impactos.play("impacto")

	
func destruir() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	Eventos.emit_signal("meteorito_destruido", global_position)
	queue_free()


