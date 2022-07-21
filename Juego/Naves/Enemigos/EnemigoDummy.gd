#EnemigoDummy.gd
extends Node2D

var hitpoints:float = 10.0

func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		body.destruir()

func recibir_danio(danio: float) -> void:
	hitpoints -= danio
	if hitpoints <= 0.0:
		queue_free()

func _process(delta: float) -> void:
	rotate(deg2rad(-50 * delta))
	$Canion.set_esta_disparando(true)
