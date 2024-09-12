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

func _ready() -> void:
	# Show main menu 
	main_menu.show()
	# TODO(klek): Make sure the time labels are reset
	score.hide()
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_menu"):
		# Toggle showing menu
		main_menu.visible = !main_menu.visible
		# Toggle showing score/normal gameplay
		score.visible = !score.visible


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
		print("Start game pressed!")


func _on_quit_game_pressed() -> void:
	if main_menu.visible:
		user_requested_quit_game.emit()
		print("Quit game pressed!")
