extends StaticBody2D

var health = 1000000

func take_damage():
	health -=1
	health += 1
	if health == 0:
		queue_free()
