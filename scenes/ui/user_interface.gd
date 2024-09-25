extends CanvasLayer
class_name user_interface

# Signals that the UI can generate
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


func _ready() -> void:
	# Show main menu 
	main_menu.show()
	# Hide the resume game button
	resume_game.hide()
	# TODO(klek): Make sure the time labels are reset
	score.hide()
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_menu"):
		# Toggle showing menu
		main_menu.visible = !main_menu.visible
		# Toggle showing score/normal gameplay
		score.visible = !score.visible


func update_time_elapsed(current_time : date_time) -> void:
	time_elapsed.text = ( str(current_time.minutes).pad_zeros(2) + ":" + 
						  str(current_time.seconds).pad_zeros(2) + ":" +
						  str(current_time.centesimal).pad_zeros(2) )


func update_nr_of_tries(tries : int ) -> void:
	nr_of_tries.text = "Tries: " + str(tries)


func hide_main_menu() -> void:
	# Hide the main menu
	main_menu.hide()
	# Show the score
	score.show()


func _on_resume_game_pressed() -> void:
	if main_menu.visible:
		user_requested_resume_game.emit()
		print("Resume game pressed!")
		hide_main_menu()


func _on_start_game_pressed() -> void:
	if main_menu.visible:
		user_requested_start_game.emit()
		print("Start/Restart game pressed!")
		# Change the text on the start game button
		start_game.text = "Restart"
		# Unhide the resume butting
		resume_game.show()
		hide_main_menu()


func _on_quit_game_pressed() -> void:
	if main_menu.visible:
		user_requested_quit_game.emit()
		print("Quit game pressed!")
