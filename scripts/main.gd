extends Node2D

func _ready() -> void:
	LevelManager.level_container = $Levels
	LevelManager.player = $Player
	
	if SaveManager.has_save():
		SaveManager.load_game()
	else:
		LevelManager.change_level("res://scenes/level/area1/area1_level.tscn", &"start")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("save"):
		SaveManager.save_game()
	if event.is_action_pressed("testlevel"):
		LevelManager.change_level("res://scenes/level/test_level.tscn", &"start")
