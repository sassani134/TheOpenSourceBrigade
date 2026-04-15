class_name defaultPlayer3D extends CharacterBody3D

# nodes
@onready var multi_jump_timer: Timer = $Timers/MultiJumpTimer


@export var speed: float = 5.0
@export var jump_velocity: float = 4.5
@export var acceleration: float = 25.0 # Accélération (plus c'est haut, plus c'est réactif)
@export var friction: float = 5.0 # Friction au sol
@export var gravity: float = 9.8

@export var mouse_sensitivity: float = 0.2

var is_mobile: bool
var is_key_mouse: bool
var is_gamepad: bool

var doDash: bool = false
var canDash: bool = true
var is_on_air: bool = false
var jumpCount: int = 0
var velocityOnJump: Vector3 = Vector3.ZERO


func _ready() -> void:
	# Optionnel : capture la souris pour un vrai contrôle
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass


func _physics_process(delta: float) -> void:
	print(velocityOnJump)
	# --- Gravité ---
	if not is_on_floor():
		velocity.y -= gravity * delta
		multi_jump_timer.start()

	# --- Saut ---
	if Input.is_action_just_pressed("right_button") and is_on_floor():
		var canThirdJump: int = jumpCount == 2 and velocity != Vector3.ZERO

		if canThirdJump < 2 or canThirdJump:
			jumpCount += 1
		else:
			jumpCount = 1
		
		velocity.y = jump_velocity * jumpCount

	if Input.is_action_just_pressed("right_button") and is_on_wall_only():
		_do_wall_jump()
		
	# --- Mouvement horizontal ---
	var input_dir := Input.get_vector("move_stick_left", "move_stick_right", "move_stick_up", "move_stick_down")
	
	# Direction dans l'espace monde (en tenant compte de la rotation du joueur)
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		# Accélération vers la direction voulue
		velocity.x = move_toward(velocity.x, direction.x * speed, acceleration * delta)
		velocity.z = move_toward(velocity.z, direction.z * speed, acceleration * delta)
	else:
		# Décélération (friction) quand on ne bouge plus
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		velocity.z = move_toward(velocity.z, 0, friction * delta)

	# --- Application du mouvement ---
	move_and_slide()

	# Debug (à enlever ou à conditionner en release)
	# if Input.is_action_just_pressed("debug_print"):
	#     print("Velocity: ", velocity)


# ====================== Rotation avec la souris ======================
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		# Rotation horizontale (Yaw)
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
		# Rotation verticale (Pitch) - optionnel pour un personnage
		# $Head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		# $Head.rotation.x = clamp($Head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

# ====================== Rotation avec la manettes ======================


func _do_wall_jump() -> void:
	var collisionNormal: Vector3 = get_last_slide_collision().get_normal()
	
	#if the player jumps exactly at the wall witout velocity
	var noVelocity: bool = velocityOnJump.x == 0 and velocityOnJump.z == 0
	
	if noVelocity:
		velocityOnJump = - collisionNormal * speed
	
	velocity = velocityOnJump.bounce(collisionNormal)
	velocity.y = jump_velocity

	velocityOnJump = velocity

	# look in jump direction, third person setup
	# var targetPosition = global_position + Vector3(velocity.x, 0, velocity.z)
	# self.look_at(targetPosition, Vector3.UP, true)
	

func _on_multi_jump_timer_timeout() -> void:
	jumpCount = 0
