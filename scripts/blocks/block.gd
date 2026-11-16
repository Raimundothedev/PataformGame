extends StaticBody2D
class_name Block

@export var breakable: bool = false	
@export var block_level: int = 1
var is_destroyed

func _ready() -> void:
	add_to_group("persistent")
	
func destroy(break_level):
	if breakable:
		if break_level < self.block_level:
			return
		is_destroyed = true
		hide()
		process_mode = Node.PROCESS_MODE_DISABLED

func get_save_data() -> Dictionary:
	return{
		"position" = global_position,
		"is_destroyed" = is_destroyed
	}
	
func load_save_data(data: Dictionary) -> void:
	if data.get("is_destroyed", false):
		queue_free()
		return
		
	global_position = data.get("position", global_position)
