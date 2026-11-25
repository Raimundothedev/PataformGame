extends StaticBody2D
class_name Block

@export var breakable: bool = false	
@export var block_level: int = 1
@export var damage: int = 0
@onready var hitbox: Area2D = get_node_or_null("Hitbox")
var is_destroyed

func _ready() -> void:
	add_to_group("persistent")
	if hitbox:
		hitbox.body_entered.connect(_on_body_entered)
	
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
	
func _on_body_entered(body: Node2D):
	if not body.is_in_group("player"):
		return
	if damage <= 0:
		return
	body.stats.take_damage(damage, self)
	
func load_save_data(data: Dictionary) -> void:
	if data.get("is_destroyed", false):
		queue_free()
		return
		
	global_position = data.get("position", global_position)
