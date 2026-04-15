extends CharacterBody3D

@export var SPEED = 5.0
@export var ACCEL = 10.0
@export var DECEL = 10.0
@export var AIR_ACCEL = 5.0
@export var AIR_DECEL = 2.0
@export var JUMP_VELOCITY = 4.5
@export var TRIPLE_JUMP_VELOCITIES = [4.5, 6.5, 9.0]
@export var WALL_JUMP_VELOCITY = 7.0
@export var WALL_JUMP_PUSHBACK = 6.0
@export var TRIPLE_JUMP_WINDOW = 0.3 # Time in seconds to land and jump again

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var jump_count = 0
var last_land_time = 0.0
var was_on_floor = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("right_button"):
		if is_on_floor():
			var current_time = Time.get_ticks_msec() / 1000.0
			
			# Check for triple jump window and if player was moving
			var is_moving = Vector2(velocity.x, velocity.z).length() > 0.1
			if current_time - last_land_time < TRIPLE_JUMP_WINDOW and was_on_floor and is_moving:
				jump_count = (jump_count + 1) % 3
			else:
				jump_count = 0
				
			velocity.y = TRIPLE_JUMP_VELOCITIES[jump_count]
		elif is_on_wall_only():
			# Wall jump
			var wall_normal = get_wall_normal()
			velocity.y = WALL_JUMP_VELOCITY
			velocity.x = wall_normal.x * WALL_JUMP_PUSHBACK
			velocity.z = wall_normal.z * WALL_JUMP_PUSHBACK
			# Reset jump count on wall jump
			jump_count = 0

	# Get the input direction and handle the movement/deceleration.
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

	# Record landing time for triple jump
	if is_on_floor() and not was_on_floor:
		last_land_time = Time.get_ticks_msec() / 1000.0
		
	was_on_floor = is_on_floor()
	move_and_slide()
