extends CharacterBody3D

signal hit_ground()

@export var speed: float = 5.0
@export var jump_velocity: float = 4.5


@onready var camera_pivot: Node3D = %cameraPivot
@onready var spring_arm: SpringArm3D = %SpringArm3D
@onready var camera: Camera3D = %Camera3D
var _cam_input: Vector2 = Vector2.ZERO
@export var mouse_sensitivity: float = 0.2
@export var rotation_speed: float = 12.0
@export var controller_sensitivity := 80.0 # Sensibilité manette (à ajuster)
@export var controller_deadzone := 0.1 # Zone morte du stick

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
	# Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	# Signals
	coyote_timer.timeout.connect(_on_coyote_timer_timeout)
	triple_jump_timer.timeout.connect(_on_triple_jump_timer_timeout)
	hit_ground.connect(_on_hit_ground)

func _input(event: InputEvent) -> void:
	# exit game
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta # Add the gravity.
		if triple_jump_timer.is_stopped() == false:
			triple_jump_timer.stop()
	if not is_on_floor() and not has_jumped and coyote_timer.is_stopped():
		coyote_timer.start()
		
	# Handle jump.
	if Input.is_action_just_pressed("right_button") and is_on_floor():
		has_jumped = true
		if jump_count > 2:
			jump_count = 1
		else:
			jump_count += 1
		velocity.y = jump_velocity * jump_count

	# Handle coyote jump
	if Input.is_action_just_pressed("right_button") and not coyote_timer.is_stopped() and not is_on_floor():
		has_jumped = true
		coyote_timer.stop()
		if jump_count > 2:
			jump_count = 1
		else:
			jump_count += 1
		velocity.y = jump_velocity * jump_count

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_stick_left", "move_stick_right", "move_stick_up", "move_stick_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	$"DebugHUD/HBoxContainer/VBoxContainerData/InputDirectionData".text = str(input_dir)
	$"DebugHUD/HBoxContainer/VBoxContainerData/DirectionData".text = str(direction)

	# $MeshInstance3D.look_at(self.global_position + direction)
	# $MeshInstance3D.rotation.y = input_dir.angle()
	

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
	if has_jumped and is_on_floor():
		hit_ground.emit()
		has_jumped = false

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
