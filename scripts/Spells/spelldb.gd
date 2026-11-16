extends Node

var spells = {
	"fireball": preload("res://scenes/spells/fire_ball.tscn"),
	"pickaxe": preload("res://scenes/spells/pickaxe_spell.tscn"),
	"ak47": preload("res://scenes/spells/ak_47.tscn")
}

func get_spell(s_name: String) -> PackedScene:
	return spells.get(s_name)
