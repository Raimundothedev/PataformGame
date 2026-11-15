extends Camera2D

@onready var player: CharacterBody2D = get_parent()

func _ready() -> void:
	position_smoothing_enabled = true
	position_smoothing_speed = 5.0
