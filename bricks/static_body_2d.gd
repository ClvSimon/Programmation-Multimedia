extends StaticBody2D

signal brick_destroyed

func _ready():
	collision_layer = 1
	collision_mask = 1

func detruire_brique():
	print("Brique touchée et détruite !")
	
	emit_signal("brick_destroyed")
	
	queue_free()
