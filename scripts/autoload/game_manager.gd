extends Node

var target_spawn: String
var camera_zoom: Vector2 = Vector2(1.25, 1.25)

func toggle_fullscreen() -> void:
	if DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		
func toggle_borderless() -> void:
	if DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		
func set_resolution(width: int, height: int) -> void:
	DisplayServer.window_set_size(Vector2i(width, height))

func freeze_game():
	get_tree().paused = true
func unfreeze_game():
	get_tree().paused = false
