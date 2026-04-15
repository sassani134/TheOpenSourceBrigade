extends CharacterBody3D
# sources
# https://docs.godotengine.org/en/stable/tutorials/physics/using_character_body_2d.html
# https://docs.godotengine.org/en/stable/classes/class_characterbody3d.html

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var camera_pivot: Node3D = %cameraPivot
@onready var spring_arm_3d: SpringArm3D = %SpringArm3D
@onready var camera_3d: Camera3D = %Camera3D

@onready var coyote_timer: Timer = $Timers/coyoteTimer
@onready var triple_jump_timer: Timer = $Timers/tripleJumpTimer
@onready var flash_timer: Timer = $Timers/FlashTimer

var was_on_air : bool = false
var do_dash : bool
var can_dash : bool
var jump_count : int

func _ready() -> void:
	pass

func _input(_event: InputEvent) -> void:
	# mouse keyboard camera
	pass

func _physics_process(delta: float) -> void:
	
	if is_on_floor():
		pass
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("right_button") and is_on_floor():
		velocity.y = JUMP_VELOCITY

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
	# velocity.x +ou- = 5 positive quand joystick a droite
	# velocity.z +ou- = 5 positive stick bas
	# Direction and input dir are the same
	# + ou - 1 (0.9....) x+=joystickdroite z+=joystickBas
	# velocity.y chaque frame en l'aire la gravite y est multiplié peut etre clamp sa
	# if is_on_floor(): and ground_pound and velocity.y = -x : screen shake
	# https://github.com/Ev01/PlatformerController2D/blob/main/platformer_controller/platformer_controller.gd#L161

func _process(_delta: float) -> void:
	$DebugHUD/HBoxContainer/VBoxContainerData/VelocityData.text = str(velocity)
	$"DebugHUD/HBoxContainer/VBoxContainerData/3pleJumpData".text = str("N/A")
	$"DebugHUD/HBoxContainer/VBoxContainerData/3pleJumpTimeLeftData".text = str(triple_jump_timer.wait_time)
	$DebugHUD/HBoxContainer/VBoxContainerData/coyoteTimeLeftData.text = str(coyote_timer.wait_time)
	$DebugHUD/HBoxContainer/VBoxContainerData/NBJumpsInAirAlloWedData.text = str("N/A")
	$DebugHUD/HBoxContainer/VBoxContainerData/JumpBufferData.text = str("N/A")
	$DebugHUD/HBoxContainer/VBoxContainerData/BlinkTimerData.text = str(flash_timer.wait_time)
	$DebugHUD/HBoxContainer/VBoxContainerData/FrameData.set_text(str(Engine.get_frames_per_second()))
	#camera_manette


func _on_coyote_timer_timeout() -> void:
	print("on_coyote_timer_timeout")
	pass # Replace with function body.


func _on_triple_jump_timer_timeout() -> void:
	print("on_triple_jump_timer_timeout")
	pass # Replace with function body.
