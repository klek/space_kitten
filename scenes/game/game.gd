class_name game
extends Node


#@export var ui_scene : PackedScene
@export var world_scene : PackedScene
@export var player_scene : PackedScene

@onready var ui: user_interface = %user_interface
@onready var clock: stop_watch = %clock

# Variables for tracking the amount of re-tries
var _nr_or_retries : int = -1

# Variables for tracking name
var _node_name_world : String = ""
var _node_name_player : String = ""

# Countdown timer
var _countdown_timer : countdown_timer = countdown_timer.new()

# Variables for tracking time passed
var _time_splits : Array[date_time] = []

func _ready() -> void:
    # Connect signals from ui to the local callbacks
    ui.user_requested_open_menu.connect(_on_user_requested_open_menu)
    ui.user_requested_quit_game.connect(_on_user_requested_quit_game)
    ui.user_requested_resume_game.connect(_on_user_requested_resume_game)
    ui.user_requested_start_game.connect(_on_user_requested_start_game)

    # Add the countdown timer to the tree
    add_child(_countdown_timer)
    # Connect countdown timer signals
    _countdown_timer.on_one_second_hit.connect(_on_one_sec_hit_timer)
    _countdown_timer.on_countdown_timeout.connect(_on_countdown_timeout_timer)


func _input(event: InputEvent) -> void:
    if event.is_action_pressed("quit"):
        quit_game()
    if event.is_action_pressed("restart"):
        _on_user_requested_start_game()
    if event.is_action_pressed("open_menu"):
        pause_game()


func _process(_delta: float) -> void:
    var data : date_time = clock.get_time()
    var msg : String = data.convert_date_time_to_string_msc()
    ui.time_elapsed_update(msg)

    # If _time_splits.size() is different than our UI time splits
    # size
    # Then we redo the UI time splits
    if ui.time_splits_size() != _time_splits.size():
        ui.time_splits_reset()
        for c in _time_splits:
            ui.time_splits_add(c.convert_date_time_to_string_msc())


func pause_game():
    get_tree().paused = true


func unpause_game():
    get_tree().paused = false


func reload_game() -> void:
    # Load the world we are gonna use
    # If the world has already been loaded, we change the scene
    if !_node_name_world.is_empty():
        # Remove the old world
        var node_world : Node = get_node(_node_name_world)
        remove_child(node_world)
        node_world.queue_free()
        # Set the string value to zero
        _node_name_world = ""

    if !_node_name_player.is_empty():
        # Remove the old player
        var node_player : Node = get_node(_node_name_player)
        remove_child(node_player)
        node_player.queue_free()
        # Set the string value to zero
        _node_name_player = ""

    var scene_world : Node2D = load_scene(world_scene)
    if ( scene_world == null ):
        # To be replaced with a quit function
        quit_game()
        return
    # Add the world as a child
    add_child(scene_world, true)
    # Save the node name
    _node_name_world = scene_world.name
    # Connect the time split signals
    # NOTE(klek): Here we are assuming that the scene_world has a
    # signal named new_time
    scene_world.new_time.connect(_on_new_time_split)

    # Grab the starting position for the player in this world
    var start_position : Vector2 = Vector2.ZERO
    if ( get_node(_node_name_world).has_method("get_start_position") ):
        start_position = get_node(_node_name_world).get_start_position()

    # Load the player
    var scene_player : Node2D = load_scene(player_scene)
    if ( scene_player == null ):
        # To be replaced with a quit function
        quit_game()
        return
    # Set the starting position for the player
    scene_player.global_position = start_position
    # Add the player as a child
    add_child(scene_player, true)
    # Save the node name
    _node_name_player = scene_player.name


func load_scene( scene_to_load: PackedScene ) -> Node2D:
    # Check that ui_scene is set
    if ( scene_to_load == null ):
        print("Exported variable ui_scene is not set...exiting!")
        return null
    # Load the scene
    var scene = scene_to_load.instantiate()
    #add_child(scene, true)
    print("Loaded scene: ", scene.name)
    return scene


func quit_game() -> void:
    get_tree().quit()


func mouse_cursor_show() -> void:
    Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func mouse_cursor_hide() -> void:
    Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

#**********************************************************************
# Callbacks for UI elements
func _on_user_requested_open_menu() -> void:
    mouse_cursor_show()


func _on_user_requested_quit_game() -> void:
    quit_game()


func _on_user_requested_resume_game() -> void:
    unpause_game()
    # TODO(klek): Hide the mouse
    mouse_cursor_hide()


func _on_user_requested_start_game() -> void:
    # Pause the game world
    pause_game()
    # Reload the world and player
    reload_game()
    # Restart the clock
    clock.restart()
    # Increment nr of tries
    _nr_or_retries += 1
    ui.nr_of_tries_update(_nr_or_retries)
    # Reset the clock ui
    ui.time_elapsed_update(clock.get_time().convert_date_time_to_string_msc())
    # Reset time splits
    _time_splits.clear()
    # Reset the time splits ui
    #ui.time_splits_reset()
    # Start countdown timer
    _countdown_timer.start(3)
    # Unpause the game world
    # TODO(klek): Hide the mouse
    mouse_cursor_hide()
    #unpause_game()

#**********************************************************************
# Callbacks for the countdown timer during start of level
func _on_one_sec_hit_timer(val : int ) -> void:
    # TODO(klek): Update GUI countdown to show new value
    ui.countdown_show("Get ready!\n" + str(val))


func _on_countdown_timeout_timer() -> void:
    # TODO(klek): Update GUI countdown to be hidden
    ui.countdown_hide()
    # Unpause the game
    unpause_game()
    #pass

func _on_new_time_split(_body : Node2D) -> void:
    # When a new split time is hit, store locally and add a child
    # to the UI element?
    _time_splits.append( clock.get_time() )
    print(" New split: " + str( clock.get_time().convert_date_time_to_string_msc() ) )
