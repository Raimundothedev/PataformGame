extends Node

var current_level: Node2D
var target_spawn: StringName
var level_container
var player: CharacterBody2D

func _ready() -> void:
	level_container = get_tree().current_scene.get_node("Levels")
	player = get_tree().get_first_node_in_group("player")
	
func change_level(scene_path: String, spawn_id: StringName) -> void:
	load_level(scene_path)
	place_player(spawn_id)

func load_level(scene_path: String) -> void:
	var scene: PackedScene = load(scene_path)
	if scene == null:
		return
		
	if current_level:
		SaveManager.save_level(current_level)
	unload_level()

	var instance = scene.instantiate()
	level_container.add_child(instance)
	current_level = instance
	
	SaveManager.load_level(current_level)
	
func unload_level() -> void:
	if not current_level:
		return
	level_container.remove_child(current_level)
	current_level.queue_free()
	current_level = null
	
func find_spawn(spawn_id: StringName) -> SpawnPoint:
	var spawn_points = get_tree().get_nodes_in_group("spawn_points")

	for spawn in spawn_points:
		if spawn.spawn_id == spawn_id:
			return spawn

	return null
	
func place_player(spawn_id: StringName) -> void:
	var spawn_point = find_spawn(spawn_id)
	if not player:
		return
	if not spawn_point is SpawnPoint:
		return
	player.global_position = spawn_point.global_position
	return
	
