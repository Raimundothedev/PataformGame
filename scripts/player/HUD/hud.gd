extends CanvasLayer

@onready var health_bar: TextureProgressBar = $Control/ProgressBar
@onready var mana_bar: TextureProgressBar = $Control/ProgressBar2
@onready var health_label: Label = $Control/Health
@onready var mana_label: Label = $Control/Mana
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var player_stats: Node = player.get_node("Stats")
@export var _scale: float = 1.5
@export var show_attr_values: bool = false


func _ready() -> void:
	scale = Vector2.ONE * _scale
	player_stats.health_changed.connect(update_health)
	player_stats.mana_changed.connect(update_mana)
	health_label.text = ""
	mana_label.text = ""
	
	update_health(player_stats.hp)
	update_mana(player_stats.mana)
	
	
func update_health(value: float) -> void:
	health_bar.value = value
	if show_attr_values:
		health_label.text = "%s / %s" % [value, player_stats.max_hp]
	
func update_mana(value: float) -> void:
	mana_bar.value = value
	if show_attr_values:
		mana_label.text = "%s / %s" % [value, player_stats.max_mana]
