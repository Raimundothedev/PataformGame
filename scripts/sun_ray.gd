extends Sprite2D

@export var min_opacity := 0.15
@export var max_opacity := 0.3
@export var duration := 4.0

func _ready() -> void:
	var tween = create_tween()
	tween.set_loops()

	tween.tween_property(
		self,
		"modulate:a",
		max_opacity,
		duration
	)

	tween.tween_property(
		self,
		"modulate:a",
		min_opacity,
		duration
	)
