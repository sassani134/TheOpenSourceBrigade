extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var camera_3d: Camera3D = $OrbitView/Camera3D

@export var ACCEL = 10.0
@export var DECEL = 10.0
@export var AIR_ACCEL = 5.0
@export var AIR_DECEL = 2.0



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	#implements a circular counter that cycles through the values 0, 1, and 2 infinitely without ever exceeding 2
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_stick_left", "move_stick_right", "move_stick_up", "move_stick_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var accel = ACCEL if is_on_floor() else AIR_ACCEL
	var decel = DECEL if is_on_floor() else AIR_DECEL

	if direction:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, accel * delta * SPEED)
		velocity.z = move_toward(velocity.z, direction.z * SPEED, accel * delta * SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, decel * delta * SPEED)
		velocity.z = move_toward(velocity.z, 0, decel * delta * SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
