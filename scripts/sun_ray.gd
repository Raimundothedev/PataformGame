extends Sprite2D

@export var min_opacity := 0.6
@export var max_opacity := 0.8
@export var duration := 2.0

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
