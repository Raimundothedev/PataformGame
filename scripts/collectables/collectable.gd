extends Area2D
class_name Collectible

@export var c_name: String = "none"
@export var can_collect: bool = true
@export_enum("health", "mana", "speed", "attribute") var effect_type: String
@export var effect_amount: int

@onready var player: CharacterBody2D
@onready var hitbox: Area2D = $Hitbox

var collected = false

var effects = [
	"health",
	"mana",
	"speed",
	"attribute"
]

func _ready() -> void:
	add_to_group("persistent")
	hitbox.body_entered.connect(_on_body_entered)
	player = get_tree().get_first_node_in_group("player")

func _on_body_entered(body: Node2D):
	if not body.is_in_group("player"):
		return
	if collect(effect_amount):
		destroy()
	
func collect(amount=0) -> bool:
	if not can_collect:
		return false
	if not effect_type in effects:
		return false
	match effect_type:
		"health":
			if player.stats.hp == player.stats.max_hp:
				return false
			player.stats.restore_hp(amount)
		"mana":
			if player.stats.mana == player.stats.max_mana:
				return false
			player.stats.restore_mana(amount)
		"attribute":
			return change_attribute()
		_:
			return false
	return true
			
func change_attribute() -> bool:
	return	false
	
func destroy():
	collected = true
	hide()
	process_mode = Node.PROCESS_MODE_DISABLED
	
func get_save_data() -> Dictionary:
	return{
		"position" = global_position,
		"collected" = collected
	}
	
func load_save_data(data: Dictionary) -> void:
	if data.get("collected", false):
		queue_free()
		return
	global_position = data.get("position", global_position)
