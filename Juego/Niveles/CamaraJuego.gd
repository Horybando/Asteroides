#CamaraJuego.gd
class_name CamaraJuego
extends Camera2D

#Atributos
var zoom_original:Vector2
var puede_hacer_zoom:bool = true setget set_puede_hacer_zoom

## Atributos export
export var variacion_zoom:float = 0.1
export var zoom_minimo:float = 0.8
export var zoom_maximo:float = 1.5

# Onready var
onready var tween_zoom:Tween = $TweenZoom

## Setters y getters
func set_puede_hacer_zoom(puede: bool) -> void:
	puede_hacer_zoom = puede
	
## Metodos
func _ready() -> void:
	zoom_original = zoom
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		controlar_zoom(-variacion_zoom)
	elif event.is_action_pressed("zomm_out"):
		controlar_zoom(variacion_zoom)
		
## Metodos custom
func controlar_zoom(mod_zoom: float) -> void:
	var zoom_x = clamp(zoom.x + mod_zoom, zoom_minimo, zoom_maximo)
	var zoom_y = clamp(zoom.y + mod_zoom, zoom_minimo, zoom_maximo)
	zoom_suavizado(zoom_x, zoom_y, 0.15)

func devolver_zoom_original() -> void:
	puede_hacer_zoom = false
	zoom_suavizado(zoom_original.x, zoom_original.y, 1.0)
		
func zoom_suavizado(nuevo_zoom_x: float, nuevo_zomm_y: float, tiempo_transicion: float) -> void:
	tween_zoom.interpolate_property(
		self,
		"zoom",
		zoom,
		Vector2(nuevo_zoom_x, nuevo_zomm_y),
		tiempo_transicion,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	tween_zoom.start()
