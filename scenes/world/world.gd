extends Node2D

func _process(delta: float) -> void:
    if Input.is_action_pressed("quit"):
        get_tree().quit()
    if Input.is_action_pressed("restart"):
        get_tree().reload_current_scene()

func new_split_time_register(body: Node2D):
    # Check that the body has not been registered before
    #if ( body )
    pass


func _on_split_time_new_split(body: Variant) -> void:
    pass # Replace with function body.
