extends Node2D

func _ready() -> void:
	LevelManager.change_level("res://scenes/level/main_level.tscn", "default")
