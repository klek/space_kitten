class_name time_split_element
extends Node2D

signal new_time_split(body : Node2D)

@onready var time_split_zone: Area2D = %time_split_zone

func _ready() -> void:
	time_split_zone.body_entered.connect(_on_body_entered)


func _on_body_entered(body : Node2D) -> void:
	new_time_split.emit(body)
	print( str(body.name) + " entered split-zone")
	# Free ourselfs such that we cannot trigger more time splits
	queue_free()
