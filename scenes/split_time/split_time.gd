extends Node2D

signal new_split(body)

func _on_area_2d_body_entered(body: Node2D) -> void:
	new_split.emit(body)


func _on_new_split(body: Variant) -> void:
	pass # Replace with function body.
