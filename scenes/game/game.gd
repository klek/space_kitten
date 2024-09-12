extends Node
class_name game

@onready var flying_saucer: RigidBody2D = $flying_saucer

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_user_interface_user_requested_quit_game() -> void:
	get_tree().quit()


func _on_user_interface_user_requested_resume_game() -> void:
	pass # Replace with function body.


func _on_user_interface_user_requested_start_game() -> void:
	#get_tree().reload_current_scene()
	# Reset the players position by re-spawning the player at the
	# starting position
	#if flying_saucer.has_method("teleport"):
	#	flying_saucer.teleport()
	pass
