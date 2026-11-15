extends Enemy

var jumped := false

func _physics_process(delta: float) -> void:
	if is_on_floor() and abs(velocity.x) > 1:
		if not jumped:
			jumped = true
			animated_sprite_2d.play("jump")

		if animated_sprite_2d.animation == "jump":
			if animated_sprite_2d.frame >= 3:
				handle_jump()

	super._physics_process(delta)

	if is_on_floor():
		jumped = false
