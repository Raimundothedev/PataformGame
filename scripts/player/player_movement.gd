extends Node

@onready var player = get_parent()
@onready var stats = player.get_node("Stats")
@onready var effect_scene = preload("res://scenes/effects/multiple_jump_effect.tscn")

@export var acceleration: float = 1200.0
@export var friction: float = 1200.0
@export var dash_velocity: float = 500
@export var dash_cooldown: float = 5

@export var jump_amplifier: float = 1.2
@export var jump_velocity: float = -400.0
@export var jump_gravity: float = 1100.0
@export var fall_gravity: float = 1500.0
@export var jump_hold_gravity: float = 800.0
@export var jump_hold_duration: float = 0.15
var jump_hold_timer: float = 0.0

var direction: Vector2 = Vector2.ZERO
var last_direction := Vector2.RIGHT
var can_dash: bool = true
var can_climb: bool = false
var is_climbing: bool = false
var jump_count: int

func _ready() -> void:
	jump_count = stats.max_jumps

func player_movement(delta: float):
	handle_movement(delta)
	handle_gravity(delta)
	handle_jump()
	handle_down()
	dash_skill()
	handle_climbing()

func handle_movement(delta: float) -> void:
	var horizontal := Input.get_axis("move_left", "move_right")

	if player.attacked:
		return

	direction = Vector2(horizontal, 0.0)

	if horizontal != 0:
		last_direction = direction.normalized()
		player.velocity.x = move_toward(
			player.velocity.x,
			direction.x * stats.speed,
			acceleration * delta
		)
	else:
		player.velocity.x = move_toward(
			player.velocity.x,
			0.0,
			friction * delta
		)

func handle_gravity(delta: float) -> void:
	if can_climb:
		return

	if not player.is_on_floor():
		var gravity = fall_gravity

		if player.velocity.y < 0:
			if Input.is_action_pressed("move_up") and jump_hold_timer > 0:
				gravity = jump_hold_gravity
				jump_hold_timer -= delta
			else:
				gravity = jump_gravity

			if Input.is_action_pressed("move_up"):
				gravity = jump_hold_gravity

		player.velocity.y += gravity * delta

	if player.is_on_floor():
		jump_count = stats.max_jumps
		
func handle_jump() -> void:
	if player.attacked:
		return
		
	if can_climb:
		return
	
	if Input.is_action_just_pressed("move_up"):
		if player.is_on_floor():
			player.velocity.y = jump_velocity
			return
		multiple_jumps()
		
func multiple_jumps() -> void:
	if player.attacked:
		return
	
	if can_climb:
		return
	
	if jump_count <= 0:
			return
	jump_count -= 1
	player.velocity.y = jump_velocity * jump_amplifier
	for i in range(randi_range(1, 5)):
		var effect = effect_scene.instantiate()
		effect.global_position = player.global_position + Vector2(
			randi_range(-20, 0),
			randi_range(20, 50)
		)
		get_tree().current_scene.add_child(effect)
		
func handle_down() -> void:
	if player.attacked:
		return
	if Input.is_action_just_pressed("move_down") and player.is_on_floor():
		player.position.y += 5
		player.velocity.y = 50
		
func dash_skill() -> void:
	if not can_dash:
		return
	if Input.is_action_just_pressed("dash_skill"):
		for i in range(randi_range(1, 5)):
			var effect = effect_scene.instantiate()
			var effect_x: int
			if direction[0] > 0:
				effect_x = -10
			else:
				effect_x = 10
			effect.global_position = player.global_position + Vector2(
				effect_x,
				20
			)
			effect._scale = 0.8
			effect.new_scale = 0.4
			effect.effect_duration = 0.55
			get_tree().current_scene.add_child(effect)
		player.velocity.x += last_direction.x * dash_velocity
		can_dash = false
		await get_tree().create_timer(dash_cooldown).timeout
		can_dash = true
		
func handle_climbing() -> void:
	if not can_climb:
		return
	
	if Input.is_action_pressed("move_up"):
		player.velocity.y = -stats.speed
	elif Input.is_action_pressed("move_down"):
		player.velocity.y = stats.speed
	else:
		player.velocity.y = 0
