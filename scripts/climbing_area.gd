extends Area2D

var player: CharacterBody2D
var p_enter: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("player"):
		return
	player = body
	p_enter = true
	
func _on_body_exited(body: Node) -> void:
	if not body.is_in_group("player"):
		return
	body.movement.can_climb = false
	p_enter = false
	
func _process(delta: float) -> void:
	if not p_enter:
		return
	if Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_down"):
		player.movement.can_climb = true
