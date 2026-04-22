extends Node3D

@onready var camera_pivot: Node3D = %cameraPivot
@onready var spring_arm_3d: SpringArm3D = %SpringArm3D
@onready var camera_3d: Camera3D = %Camera3D
@onready var mesh_instance_3d: MeshInstance3D = $"../MeshInstance3D"

@export_range(0.0, 1.0, 0.1) var mouse_sensitivity: float = 0.03
@export var tilt_limit: float = deg_to_rad(75)


@export var joystickSensitivity: float = 0.1 # Sensibilité manette (à ajuster)
@export var minZoom: float = 0.0
@export var maxZoom: float = 20.0
@export var zoomDelay: float = 5.0
@export var xAxisMinLimitDegree: float = -80.0
@export var xAxisMaxLimitDegree: float = 80.0

var targetZoom: float = 5.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	# Mouselook implemented using `screen_relative` for resolution-independent sensitivity.
	if event is InputEventMouseMotion:
		camera_pivot.rotation.x -= event.screen_relative.y * mouse_sensitivity
		# Prevent the camera from rotating too far up or down.
		camera_pivot.rotation.x = clampf(camera_pivot.rotation.x, -tilt_limit, tilt_limit)
		camera_pivot.rotation.y += -event.screen_relative.x * mouse_sensitivity

func _process(delta: float) -> void:
	_joystick_camera_control(delta)

func _joystick_camera_control(delta: float) -> void:
	var direction = Input.get_vector("cam_stick_left", "cam_stick_right", "cam_stick_up", "cam_stick_down")
	
	if Input.is_action_pressed("r_trigger_1") and direction.y < 0:
		targetZoom = spring_arm_3d.spring_length - 2
	elif Input.is_action_pressed("l_trigger_1") and direction.y > 0:
		targetZoom = spring_arm_3d.spring_length + 2
	else:
		rotation.y -= direction.x * joystickSensitivity
		rotation.x -= direction.y * joystickSensitivity
		rotation.x = clampf(rotation.x, deg_to_rad(xAxisMinLimitDegree), deg_to_rad(xAxisMaxLimitDegree))
			
	targetZoom = clamp(targetZoom, minZoom, maxZoom)
	spring_arm_3d.spring_length = lerp(spring_arm_3d.spring_length, targetZoom, zoomDelay * delta)