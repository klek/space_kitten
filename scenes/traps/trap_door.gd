class_name trap_door
extends Node2D

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var trigger_zone: Area2D = %trigger_zone

var _is_rearmed : bool = true

func _ready() -> void:
    trigger_zone.body_entered.connect(_on_body_entered_trigger_zone)
    # Setting up animation finished signal
    animation_player.animation_finished.connect(_on_animation_finished)

# TODO(klek): Need to be able to trigger trap again if the player is
# still in the zone

func _process(_delta: float) -> void:
    var bodied_in_zone : = trigger_zone.get_overlapping_bodies()
    for body : Node2D in bodied_in_zone:
        if body.is_in_group("player"):
            _on_body_entered_trigger_zone( body )

#**********************************************************************
# Callback for the trigger zone to the trap
func _on_body_entered_trigger_zone( body : Node2D ) -> void:
    if body.is_in_group("player") and _is_rearmed == true:
        animation_player.play("triggered")
        _is_rearmed = false


#**********************************************************************
# Callback for animations finishing, this can either be triggered
# or the re-arm animation
func _on_animation_finished( anim_name : StringName ) -> void:
    if ( anim_name == "triggered" ):
        # Re-arm the trap
        # TODO(klek): Consider adding a small delay between animations
        animation_player.play("rearm")
    elif ( anim_name == "rearm" ):
        _is_rearmed = true
