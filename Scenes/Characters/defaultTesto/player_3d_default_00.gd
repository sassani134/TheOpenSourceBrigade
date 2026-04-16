extends CharacterBody3D
# sources
# https://docs.godotengine.org/en/stable/tutorials/physics/using_character_body_2d.html
# https://docs.godotengine.org/en/stable/classes/class_characterbody3d.html

signal hit_ground()

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var camera_pivot: Node3D = %cameraPivot
@onready var spring_arm_3d: SpringArm3D = %SpringArm3D
@onready var camera_3d: Camera3D = %Camera3D

@onready var coyote_timer: Timer = $Timers/coyoteTimer
@onready var triple_jump_timer: Timer = $Timers/tripleJumpTimer
@onready var flash_timer: Timer = $Timers/FlashTimer


var is_mobile: bool
var is_key_mouse: bool
var is_gamepad: bool

var has_jumped: bool = false
var was_on_air: bool = false
var do_dash: bool
var can_dash: bool = true
var jump_count: int = 0

func _ready() -> void:
	pass

func _input(_event: InputEvent) -> void:
	# mouse keyboard camera
	pass

func _physics_process(delta: float) -> void:
	if is_on_floor():
		pass
	
	
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
		velocity.y = JUMP_VELOCITY * jump_count
	# Handle coyote jump
	if Input.is_action_just_pressed("right_button") and not coyote_timer.is_stopped() and not is_on_floor():
		has_jumped = true
		coyote_timer.stop()
		if jump_count > 2:
			jump_count = 1
		else:
			jump_count += 1
		velocity.y = JUMP_VELOCITY * jump_count
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_stick_left", "move_stick_right", "move_stick_up", "move_stick_down")
	var direction := Vector3(input_dir.x, 0, input_dir.y)
	$"DebugHUD/HBoxContainer/VBoxContainerData/InputDirectionData".text = str(input_dir)
	$"DebugHUD/HBoxContainer/VBoxContainerData/DirectionData".text = str(direction)
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	if has_jumped and is_on_floor():
		hit_ground.emit()
		has_jumped = false
	# velocity.x +ou- = 5 positive quand joystick a droite
	# velocity.z +ou- = 5 positive stick bas
	# Direction and input dir are the same
	# + ou - 1 (0.9....) x+=joystickdroite z+=joystickBas
	# velocity.y chaque frame en l'aire la gravite y est multiplié peut etre clamp sa
	# if is_on_floor(): and ground_pound and velocity.y = -x : screen shake
	# https://github.com/Ev01/PlatformerController2D/blob/main/platformer_controller/platformer_controller.gd#L161

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
	#camera_manette

func _on_coyote_timer_timeout() -> void:
	print("on_coyote_timer_timeout")

func _on_triple_jump_timer_timeout() -> void:
	print("on_triple_jump_timer_timeout")
	jump_count = 0


func _on_hit_ground() -> void:
	print("on_hit_ground")
	triple_jump_timer.start()
