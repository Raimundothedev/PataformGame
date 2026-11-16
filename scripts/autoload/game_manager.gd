extends Node

var target_spawn: String

func _ready() -> void:
	set_resolution(1280, 720)
	print(DisplayServer.window_get_size())

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
