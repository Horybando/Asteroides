#MenuVictoria.gd
extends Control



func _on_BotonMenuPrincipal_pressed() -> void:
	get_tree().change_scene("res://Juego/Niveles/MenuPrincipal.tscn")
	



func _on_BotonSalir_pressed() -> void:
	get_tree().quit()
