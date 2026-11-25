extends Marker2D
class_name SpawnPoint

@export var spawn_id: StringName

func _ready() -> void:
	add_to_group("spawn_points")
