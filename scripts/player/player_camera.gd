extends Camera2D

@onready var player: CharacterBody2D = get_parent()

func _ready():
	position_smoothing_enabled = true
	position_smoothing_speed = 2.0
