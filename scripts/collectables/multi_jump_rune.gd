extends Collectible

func change_attribute() -> bool:
	player.stats.max_jumps += 1
	print(player.stats.max_jumps)
	return true
