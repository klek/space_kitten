class_name pendulum
extends Node2D

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var player_detection: Area2D = %player_detection


func _ready() -> void:
    #animation_player.play("move_smooth", -1, 1.0, true)
    #animation_player.play("move_smooth")
    player_detection.body_entered.connect(_on_body_entered_player_detection_area)
    player_detection.body_exited.connect(_on_body_exited_player_detection_area)


func _on_body_entered_player_detection_area( body : Node2D ) -> void:
    if body.is_in_group("player"):
        animation_player.play("move_smooth")

func _on_body_exited_player_detection_area( body : Node2D ) -> void:
    if body.is_in_group("player"):
        animation_player.stop()
