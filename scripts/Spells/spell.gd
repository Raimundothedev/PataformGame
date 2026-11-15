extends Area2D
class_name Spell

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var tile_map: TileMap = $TileMapLayer
@export var dmg_mult: float = 1
@export var vel: float = 300.0
@export var mana_cost: float = 10.0
@export var lifetime: float = 15.0
@export var spell_type: String
@export var break_level: int = 1
@export var spell_level: int = 1
@export var effect_scene: PackedScene = preload("res://scenes/effects/fireball_hit_effect.tscn")

var player: CharacterBody2D
var damage: float

func setup(p: CharacterBody2D, m: int):
	player = p
	damage = player.stats.dmg * dmg_mult
	has_mana(m)
	
func has_mana(mana):
	if mana < mana_cost:
		queue_free()
	else:
		visible = true

func _ready() -> void:
	visible = false
	body_entered.connect(_on_body_entered)
	await get_tree().create_timer(0.1).timeout
	visible = true
	await get_tree().create_timer(lifetime).timeout
	queue_free()

var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	move_spell(delta)

func move_spell(delta: float) -> void:
	match spell_type:
		"projectile":
			global_position += direction.normalized() * vel * delta
		_:
			return
	if direction[0] < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		return
	if body is Block:
		if body.breakable:
			body.destroy(break_level)

	elif body is Enemy:
		if body.hp > 0:
			body.take_damage(damage, self)
	
	var effect = effect_scene.instantiate()
	effect.direction = direction
	effect.global_position = global_position
	get_tree().current_scene.add_child(effect)
	

	queue_free()
