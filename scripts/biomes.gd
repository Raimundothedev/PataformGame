extends Area2D
class_name BiomeZone

@export var biome_name: String = "none"
@export var biome_color: Color = Color.from_string("#508d76", Color.WHITE)
@export var transition_time: float = 1.0
@export var overlay: ColorRect

var biome_title: Control

var tween: Tween

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	biome_title = body.get_node("HUD/BiomeTitle")
	change_color(biome_color)
	show_title(biome_name)

func show_title(text: String) -> void:
	biome_title.show_biome(biome_name)
	
	
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
	

		
