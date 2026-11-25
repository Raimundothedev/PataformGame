extends Camera2D

@onready var player: CharacterBody2D = get_parent()

func _ready() -> void:
	zoom = GameManager.camera_zoom
	position_smoothing_enabled = true
	position_smoothing_speed = 1.0
