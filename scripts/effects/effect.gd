extends Node2D
class_name Effect

@onready var sprite: Sprite2D = get_node_or_null("Sprite2D")
@onready var anim_sprite: AnimatedSprite2D = get_node_or_null("AnimatedSprite2D")

@export_enum("ground", "air", "wall") var effect_type = "ground"

var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	print(direction)
	if anim_sprite:
		if direction[0] < 0:
			anim_sprite.flip_h = true
		else:
			anim_sprite.flip_h = false
		await play_anim()
	elif sprite:
		await play_static()
	queue_free()
	
func play_static() -> void:
	sprite.rotation += randf_range(0, TAU)
	var tween = create_tween()
	tween.tween_property(sprite, "scale", Vector2(1.1, 1.1), 0.3)
	tween.parallel().tween_property(sprite, "modulate:a", 0.0, 0.3)
	await tween.finished
	
func play_anim() -> void:
	anim_sprite.sprite_frames.set_animation_loop("default", false)
	anim_sprite.play("default")
	await anim_sprite.animation_finished
