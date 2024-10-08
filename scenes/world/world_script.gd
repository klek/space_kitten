extends Node2D

signal new_time(body : Node2D)

@onready var start_position: Marker2D = %start_position
@onready var time_split_0: time_split_element = %time_split_0
@onready var time_split_1: time_split_element = %time_split_1
@onready var time_split_2: time_split_element = %time_split_2
@onready var time_split_3: time_split_element = %time_split_3
@onready var time_split_4: time_split_element = %time_split_4
@onready var time_split_5: time_split_element = %time_split_5
@onready var time_split_6: time_split_element = %time_split_6


func _ready() -> void:
    # Connecting signals from each time split
    time_split_0.new_time_split.connect(_on_new_time_split)
    time_split_1.new_time_split.connect(_on_new_time_split)
    time_split_2.new_time_split.connect(_on_new_time_split)
    time_split_3.new_time_split.connect(_on_new_time_split)
    time_split_4.new_time_split.connect(_on_new_time_split)
    time_split_5.new_time_split.connect(_on_new_time_split)
    time_split_6.new_time_split.connect(_on_new_time_split)


func get_start_position() -> Vector2:
    # Get the starting position
    return start_position.to_global(position)


#**********************************************************************
# Callback for new time split
func _on_new_time_split(body : Node2D) -> void:
    new_time.emit(body)
