extends Node2D

func _ready() -> void:
	LevelManager.level_container = $Levels
	LevelManager.player = $Player
	
	LevelManager.change_level("res://scenes/level/main_level.tscn", "default")
	if SaveManager.has_save():
		SaveManager.load_game()
	else:
		LevelManager.change_level("res://scenes/level/main_level.tscn", &"start")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("save"):
		SaveManager.save_game()
