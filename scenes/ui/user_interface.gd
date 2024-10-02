extends CanvasLayer
class_name user_interface

# Signals that the UI can generate
signal user_requested_open_menu()
signal user_requested_resume_game()
signal user_requested_quit_game()
signal user_requested_start_game()

# On-ready variables
@onready var main_menu: Control = %main_menu
@onready var score: Control = %score
@onready var start_game: Button = %start_game
@onready var quit_game: Button = %quit_game
@onready var resume_game: Button = %resume_game
@onready var time_elapsed: Label = %time_elapsed
@onready var nr_of_tries: Label = %nr_of_tries
@onready var countdown: Label = %countdown
@onready var time_splits: GridContainer = %time_splits


func _ready() -> void:
    # Show main menu
    main_menu.show()
    # Hide the resume game button
    resume_game.hide()
    # TODO(klek): Make sure the time labels are reset
    score.hide()
    pass


func _input(event: InputEvent) -> void:
    # TODO(klek): Consider moving this input handling to the game script!
    if event.is_action_pressed("open_menu"):
        if !(main_menu.visible):
            # Toggle showing menu
            #main_menu.visible = !main_menu.visible
            main_menu_show()
            # Toggle showing score/normal gameplay
            #score.visible = !score.visible
            # TODO(klek): Show the mouse
            #Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
            user_requested_open_menu.emit()

        # TODO: If "open_menu" pressed again it still pauses the game
        # Should perhaps disable escaping the menu by pressing ESQ?


#**********************************************************************
# Functions related to the clock elements of the UI
## Function to update the elapsed time in the UI time_elapsed label
func time_elapsed_update( val : String ) -> void:
    time_elapsed.text = val


#**********************************************************************
# Functions related to the "tries" element of the UI
## Function to update the number of tries in the UI nr_of_tries label
func nr_of_tries_update(tries : int ) -> void:
    nr_of_tries.text = "Tries: " + str(tries)


#**********************************************************************
# Functions related to the time_splits panel
## Function that returns the size of the time_splits table
func time_splits_size() -> int:
    return time_splits.get_child_count()


## Function to add a new split to the time_splits table
func time_splits_add( val : String ) -> void:
    var new_split = Label.new()
    new_split.text = val
    time_splits.add_child(new_split)


## Function that resets/removes all the children of the time_splits
## table
func time_splits_reset() -> void:
    var children : Array[Node] = time_splits.get_children()
    for c in children:
        time_splits.remove_child(c)
        c.queue_free()


#**********************************************************************
# Functions related to the countdown element of the UI
## Show the countdown UI element with the provided string
func countdown_show(str : String = "") -> void:
    countdown.text = str
    countdown.show()


## Function to hide the UI countdown label
func countdown_hide() -> void:
    countdown.hide()


#**********************************************************************
# Functions related to the main menu elements of the UI
## Function to hide the UI main_menu node
func main_menu_hide() -> void:
    # Hide the main menu
    main_menu.hide()
    # Show the score
    score.show()


func main_menu_show() -> void:
    # Show the main menu
    main_menu.show()
    # Hide the score
    score.hide()

#**********************************************************************
# Callbacks for main menu buttons
## Callback for the UI resume_game button
func _on_resume_game_pressed() -> void:
    if main_menu.visible:
        user_requested_resume_game.emit()
        print("Resume game pressed!")
        main_menu_hide()


## Callback for the UI start_game button
func _on_start_game_pressed() -> void:
    if main_menu.visible:
        user_requested_start_game.emit()
        print("Start/Restart game pressed!")
        # Change the text on the start game button
        start_game.text = "Restart"
        # Unhide the resume butting
        resume_game.show()
        main_menu_hide()


## Callback for the UI qui_game button
func _on_quit_game_pressed() -> void:
    if main_menu.visible:
        user_requested_quit_game.emit()
        print("Quit game pressed!")
