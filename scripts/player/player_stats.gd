extends Node

signal health_changed(hp)
signal mana_changed(mana)

@onready var player = get_parent()

# Base Atributes
@export var max_hp: float = 100
@export var max_mana: float = 100
@export var mana_regen_mult: float = 1
@export var dmg: float = 50
@export var speed: float = 300.0
@export var max_jumps: int = 1

var hp: float
var mana: float 

# Spells
@export_enum("none", "fireball", "pickaxe", "lighting") var equipped_spell: String
@export var attack_cooldown: float = 0.5

var invulnerable: bool = false

func _ready() -> void:
	hp = max_hp
	mana = max_mana

func take_damage(d: float, target: Node2D):
	if invulnerable:
		return
	hp = max(hp - d, 0)
	health_changed.emit(hp)
	invulnerable = true

	
	if hp <= 0:
		die()
	
	player.attacked = true
	var knockback_direction = (player.global_position - target.global_position).normalized()
	player.velocity.x = knockback_direction.x * 500
	player.velocity.y = -350
	
	if target.is_in_group("enemy"):
		player.add_collision_exception_with(target)
	
	await get_tree().create_timer(0.5).timeout
	player.remove_collision_exception_with(target)
	player.attacked = false
	invulnerable = false

func die() -> void:
	get_tree().paused = true
	await get_tree().create_timer(1).timeout
	get_tree().paused = false
	if SaveManager.has_save():
		SaveManager.load_game()
	else:
		LevelManager.restart_level()
	

func restore_hp(amount: int):
	hp = min(max_hp, hp + amount)
	health_changed.emit(hp)
	
func restore_mana(amount: int):
	mana = min(max_mana, mana + amount)
	mana_changed.emit(mana)
	
func spend_mana(amount: int) -> bool:
	if mana < amount:
		return false
	
	mana -= amount
	mana_changed.emit(mana)
	return true
	
var mana_regen: int
var can_regen: bool = true

func regen_mana():
	mana_regen = (max_mana / 100) * mana_regen_mult
	if not player.attacked:
		if can_regen and mana < max_mana:
			can_regen = false
			mana += mana_regen
			mana_changed.emit(mana)
			await get_tree().create_timer(1).timeout
			can_regen = true	
	
func get_save_data() -> Dictionary:
	return{
		"position" = player.global_position,
		"max_hp" = max_hp,
		"max_mana" = max_mana,
		"hp" = hp,
		"mana" = mana,
		"mana_regen_mult" = mana_regen_mult,
		"dmg" = dmg,
		"speed" = speed,
		"max_jumps" = max_jumps,
		"equipped_spell" = equipped_spell
	}
	
func load_save_data(data: Dictionary) -> void:
	player.global_position = data.get("position", player.global_position)
	max_hp = data.get("max_hp", max_hp)
	max_mana = data.get("max_mana", max_mana)
	hp = data.get("hp", hp)
	mana = data.get("mana", mana)
	mana_regen_mult = data.get("mana_regen_mult", mana_regen_mult)
	dmg = data.get("dmg", dmg)
	speed = data.get("speed", speed)
	max_jumps = data.get("max_jumps", max_jumps)
	equipped_spell = data.get("equipped_spell", equipped_spell)
	
	health_changed.emit(hp)
	mana_changed.emit(mana)
	
	
