extends RigidBody2D

@export var engine_power : float = 0
@export var engine_vector_left : Vector2 = Vector2.ZERO
@export var engine_vector_right : Vector2 = Vector2.ZERO


@onready var thruster_left: Marker2D = %thruster_left
@onready var thruster_right: Marker2D = %thruster_right
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var thruster_left_dir: RayCast2D = $thruster_left/thruster_left_dir
@onready var thruster_rigth_dir: RayCast2D = $thruster_right/thruster_rigth_dir
@onready var fire_left: Label = $thruster_left/fire_left
@onready var fire_right: Label = $thruster_right/fire_right

# Internal variables
var left_thruster_offset : Vector2
var right_thruster_offset : Vector2
var thrust_left : Vector2 = Vector2.ZERO
var thrust_right : Vector2 = Vector2.ZERO

func _ready() -> void:
	# Get the offset position of each thruster
	left_thruster_offset = thruster_left.position
	print(left_thruster_offset)
	right_thruster_offset = thruster_right.position
	print(right_thruster_offset)
	thruster_left_dir.target_position = engine_vector_left*engine_power
	thruster_rigth_dir.target_position = engine_vector_right*engine_power


func _process(delta: float) -> void:
	get_input()


#func _physics_process(delta: float) -> void:
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	#thruster_left_dir.target_position = thrust_left
	state.apply_force(thrust_left, left_thruster_offset)
	#thruster_rigth_dir.target_position = thrust_right
	state.apply_force(thrust_right, right_thruster_offset)



#func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
#	pass


func get_input() -> void:
	if Input.is_action_pressed("left_thruster"):
		#thrust_left = thruster_left.fire_thruster().rotated(rotation)
		thrust_left = engine_vector_left.normalized().rotated(rotation) * engine_power
		print("Applied thrust from left: " + str(thrust_left))
		# Get the offset position of each thruster
		left_thruster_offset = thruster_left.position.rotated(rotation)
		fire_left.show()
	else:
		thrust_left = Vector2.ZERO
		left_thruster_offset = Vector2.ZERO
		fire_left.hide()

	if Input.is_action_pressed("right_thruster"):
		#thrust_right = thruster_right.fire_thruster().rotated(rotation)
		thrust_right = engine_vector_right.normalized().rotated(rotation) * engine_power
		print("Applied thrust from right: " + str(thrust_right))
		# Get the offset position of each thruster
		right_thruster_offset = thruster_right.position.rotated(rotation)
		fire_right.show()
	else:
		thrust_right = Vector2.ZERO
		right_thruster_offset = Vector2.ZERO
		fire_right.hide()
