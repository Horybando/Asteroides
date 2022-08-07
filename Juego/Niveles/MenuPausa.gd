#MenuPausa.gd
extends Control

## Métodos
func _ready() -> void:
	visible = false
	
func _input(event) -> void:
	if event.is_action_pressed("pausa"):
		visible = not visible
		get_tree().paused = not get_tree().paused

## Señales internas

func _on_BotonContinuar_pressed():
	get_tree().paused = false
	visible = false

func _on_BotonMenuPrincipal_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Juego/Niveles/MenuPrincipal.tscn")


func _on_BotonSalir_pressed() -> void:
	get_tree().quit()




