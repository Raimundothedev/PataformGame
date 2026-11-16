extends Area2D

@export_file("*.tscn") var target_scene: String
@export var target_spawn: StringName

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		LevelManager.change_level(target_scene, target_spawn)
