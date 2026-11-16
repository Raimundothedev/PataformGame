extends Node

var saved_levels: Dictionary = {}
var objects: Array

const SAVE_PATH := "user://savegame.dat"

func save_level(level: Node) -> void:
	var level_key := level.scene_file_path
	var level_data: Dictionary = saved_levels.get(level_key, {})

	for object in _get_persistent_objects(level):
		if not object.has_method("get_save_data"):
			continue
		level_data[_get_id(level, object)] = object.get_save_data()

	saved_levels[level_key] = level_data
		
func load_level(level: Node) -> void:
	var level_key := level.scene_file_path
	if not saved_levels.has(level_key):
		return

	var level_data: Dictionary = saved_levels[level_key]

	for object in _get_persistent_objects(level):
		if not object.has_method("load_save_data"):
			continue
		var id := _get_id(level, object)
		if not level_data.has(id):
			continue
		object.load_save_data(level_data[id])
		
func _get_id(level: Node, object: Node) -> String:
	return str(level.get_path_to(object))
	
func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

func save_game() -> void:
	
	save_level(LevelManager.current_level)

	var data := {
		"version": 1,
		"current_level": LevelManager.current_level.scene_file_path,  
		"player": LevelManager.player.stats.get_save_data(),                 
		"levels": saved_levels,
	}

	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		push_error("Error while saving: %s" % FileAccess.get_open_error())
		return
	file.store_var(data)

func load_game() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		push_error("Error opening the save file: %s" % FileAccess.get_open_error())
		return

	var data = file.get_var()
	if typeof(data) != TYPE_DICTIONARY:
		push_error("Corrupted save")
		return
		
	LevelManager.unload_level()
	saved_levels = data.get("levels", {})
	LevelManager.load_level(data["current_level"])
	LevelManager.player.stats.load_save_data(data.get("player", {}))
			
func _get_persistent_objects(level: Node) -> Array[Node]:
	var result: Array[Node] = []
	for object in get_tree().get_nodes_in_group("persistent"):
		if level.is_ancestor_of(object):
			result.append(object)
	return result
