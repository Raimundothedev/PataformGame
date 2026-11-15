extends Control

@onready var title: Label = $Title

var tween: Tween

func _ready() -> void:
	visible = false

func show_biome(biome_name: String) -> void:
	if tween and tween.is_running():
		tween.kill()
	
	title.text = biome_name
	modulate.a = 0.0
	visible = true
	
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.6)
	tween.tween_interval(2.5)
	tween.tween_property(self, "modulate:a", 0.0, 0.8)
	tween.tween_callback(func(): visible = false)
