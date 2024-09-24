extends Node2D

@onready var start_position: Marker2D = %start_position

func get_start_position() -> Vector2:
	# Get the starting position 
	return start_position.to_global(position)
