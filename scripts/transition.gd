extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	color_rect.modulate.a = 0.0

func fade_out():
	var tween = create_tween()
	tween.tween_property(
		color_rect,
		"modulate:a",
		1.0,
		1.0
	)
	await tween.finished

func fade_in():
	await get_tree().create_timer(2).timeout
	
	var tween = create_tween()
	tween.tween_property(
		color_rect,
		"modulate:a",
		0.0,
		1.0
	)
	await tween.finished
	
func destroy():
	queue_free()
