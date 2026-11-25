extends Area2D
class_name Zone

@export var zone_name: String = "none"
@export var biome_color: Color = Color.from_string("#508d76", Color.WHITE)
@export var transition_time: float = 1.0
@export var zoom_amplifier: float = 0.0
@export var overlay: ColorRect

var zone_title: Control
var default_zoom: Vector2 = GameManager.camera_zoom
var camera: Camera2D

var tween: Tween

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	zone_title = body.get_node("HUD/BiomeTitle")
	camera = body.get_node("Camera2D")
	change_color(biome_color)
	show_title(zone_name)
	change_zoom(zoom_amplifier)

	

func show_title(text: String) -> void:
	zone_title.show_biome(zone_name)
	
func change_zoom(zoom) -> void:
	var target_zoom = default_zoom + Vector2(zoom, zoom)
	
	var zoom_tween = create_tween()
	zoom_tween.set_trans(Tween.TRANS_SINE)
	zoom_tween.set_ease(Tween.EASE_IN_OUT)

	zoom_tween.tween_property(
		camera,
		"zoom",
		target_zoom,
		transition_time
	)
	
	
func change_color(target: Color) -> void:
	if tween and tween.is_running():
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(
		overlay,
		"color",
		target,
		transition_time
	)
	

		
