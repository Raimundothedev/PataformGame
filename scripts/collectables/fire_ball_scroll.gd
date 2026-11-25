extends Collectible

func change_attribute() -> bool:
	player.stats.equipped_spell = "fireball"
	return true
