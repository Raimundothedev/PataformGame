extends Node

var spells = {
	"fireball": preload("res://scenes/spells/fire_ball.tscn"),
	"pickaxe": preload("res://scenes/spells/pickaxe_spell.tscn")
}

func get_spell(s_name: String) -> PackedScene:
	return spells.get(s_name)
