extends CharacterBody3D

signal hit_ground()

@export var speed: float = 5.0
@export var acceleration: float = 10.0
@export var jump_velocity: float = 4.5


@onready var camera_pivot: Node3D = %cameraPivot
@onready var spring_arm: SpringArm3D = %SpringArm3D
@onready var camera: Camera3D = %Camera3D
var _camera_input_direction: Vector2 = Vector2.ZERO
@export var mouse_sensitivity: float = 0.2
@export var rotation_speed: float = 12.0
@export var controller_sensitivity := 1.0 # Sensibilité manette (à ajuster)
@export var controller_deadzone := 0.1 # Zone morte du stick
@export var stoping_speed: float = 1.0

@onready var _last_input_direction := global_basis.z

@onready var coyote_timer: Timer = $Timers/coyoteTimer
@onready var triple_jump_timer: Timer = $Timers/tripleJumpTimer
@onready var flash_timer: Timer = $Timers/FlashTimer

var has_jumped: bool = false
var was_on_air: bool = false
var do_dash: bool
var can_dash: bool = true
var jump_count: int = 0
var crounch: bool = false


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	# Signals
	coyote_timer.timeout.connect(_on_coyote_timer_timeout)
	triple_jump_timer.timeout.connect(_on_triple_jump_timer_timeout)
	hit_ground.connect(_on_hit_ground)

func _input(event: InputEvent) -> void:
	# exit game
	# if event.is_action_just_pressed("ui_cancel"):
	# 	get_tree().quit()
	# if event.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
	# 	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
	# 		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	# 	else:
	# 		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	# Camera with joystick not viable for now
	var controller_camera_input := Input.get_vector("cam_stick_left", "cam_stick_right", "cam_stick_up", "cam_stick_down")
	if controller_camera_input.length() > controller_deadzone:
		_camera_input_direction += controller_camera_input * controller_sensitivity
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_camera_input_direction.x = - event.relative.x * mouse_sensitivity
		_camera_input_direction.y = - event.relative.y * mouse_sensitivity
	
	
func _physics_process(delta: float) -> void:
	#Camera
	camera_pivot.rotation.x += _camera_input_direction.y * delta
	camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, -PI / 2, PI / 2)
	camera_pivot.rotation.y += _camera_input_direction.x * delta

	
	_camera_input_direction = Vector2.ZERO
	
	if not is_on_floor():
		velocity += get_gravity() * delta # Add the gravity.
		if triple_jump_timer.is_stopped() == false:
			triple_jump_timer.stop()

	if not is_on_floor() and not has_jumped and coyote_timer.is_stopped():
		coyote_timer.start()
		

	# Handle jump.
	if (Input.is_action_just_pressed("right_button") or Input.is_action_just_pressed("ui_accept")) and is_on_floor():
		# jump sound tween squash 
		has_jumped = true
		if jump_count > 2:
			jump_count = 1
		else:
			jump_count += 1
		velocity.y = jump_velocity * jump_count


	# Handle coyote jump
	if (Input.is_action_just_pressed("right_button") or Input.is_action_just_pressed("ui_accept")) and not coyote_timer.is_stopped() and is_on_floor():
		has_jumped = true
		coyote_timer.stop()
		if jump_count > 2:
			jump_count = 1
		else:
			jump_count += 1
		velocity.y = jump_velocity * jump_count
	

	# mouvment
	var raw_input := Input.get_vector("move_stick_left", "move_stick_right", "move_stick_up", "move_stick_down")
	var forward := camera.global_basis.z
	var right := camera.global_basis.x
	var move_direction := forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()

	# To not orient the character too abruptly, we filter movement inputs we
	# consider when turning the skin. This also ensures we have a normalized
	# direction for the rotation basis.
	if move_direction.length() > 0.2:
		_last_input_direction = move_direction.normalized()
	var target_angle := Vector3.BACK.signed_angle_to(_last_input_direction, Vector3.UP)
	$MeshInstance3D.rotation.y = lerp_angle($MeshInstance3D.rotation.y, target_angle, rotation_speed * delta)

	# We separate out the y velocity to only interpolate the velocity in the
	# ground plane, and not affect the gravity.
	
	if move_direction != Vector3.ZERO:
		velocity.x = velocity.move_toward(move_direction * speed, acceleration * delta).x
		velocity.z = velocity.move_toward(move_direction * speed, acceleration * delta).z
	else:
		velocity.x = velocity.move_toward(Vector3.ZERO, acceleration * delta).x
		velocity.z = velocity.move_toward(Vector3.ZERO, acceleration * delta).z


	move_and_slide()

	$"DebugHUD/HBoxContainer/VBoxContainerData/InputDirectionData".text = str(raw_input)
	$"DebugHUD/HBoxContainer/VBoxContainerData/DirectionData".text = str(move_direction)
	$"DebugHUD/HBoxContainer/VBoxContainerData/LastInputDirectionData".text = str(_last_input_direction)

	if has_jumped and is_on_floor():
		hit_ground.emit()
		has_jumped = false
		#landing sound and tween squash

func _process(_delta: float) -> void:
	$DebugHUD/HBoxContainer/VBoxContainerData/VelocityData.text = str(velocity)
	$"DebugHUD/HBoxContainer/VBoxContainerData/3pleJumpData".set_text((str(jump_count)))
	$"DebugHUD/HBoxContainer/VBoxContainerData/3pleJumpTimeLeftData".text = str(triple_jump_timer.time_left)
	$DebugHUD/HBoxContainer/VBoxContainerData/coyoteTimeLeftData.text = str(coyote_timer.time_left)
	$DebugHUD/HBoxContainer/VBoxContainerData/NBJumpsInAirAlloWedData.text = str("N/A")
	$DebugHUD/HBoxContainer/VBoxContainerData/JumpBufferData.text = str("N/A")
	$DebugHUD/HBoxContainer/VBoxContainerData/BlinkTimerData.text = str(flash_timer.wait_time)
	$DebugHUD/HBoxContainer/VBoxContainerData/FrameData.set_text(str(Engine.get_frames_per_second()))
	$DebugHUD/HBoxContainer/VBoxContainerData/hasJumpedData.set_text((str(has_jumped)))
	$DebugHUD/HBoxContainer/VBoxContainerData/cameraDirectionData.set_text((str(camera.global_rotation)))
	$DebugHUD/HBoxContainer/VBoxContainerData/CharachterDirectionData.set_text((str(self.global_rotation)))


func _on_coyote_timer_timeout() -> void:
	print("on_coyote_timer_timeout")

func _on_triple_jump_timer_timeout() -> void:
	print("on_triple_jump_timer_timeout")
	jump_count = 0

func _on_hit_ground() -> void:
	print("on_hit_ground")
	triple_jump_timer.start()
