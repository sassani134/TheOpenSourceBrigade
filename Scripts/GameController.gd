class_name GameController extends Node

@onready var transition_controller: SceneTransitionController = $TransitionController

@export var world_3d: Node3D
@export var world_2d: Node2D
@export var gui: Control

var current_3d_scene: Node3D
var current_2d_scene: Node2D
# Maybe an array ???
var current_gui_scene: Control # main menu, HUD, etc

func _ready() -> void:
	Global.game_controller = self
	current_gui_scene = $GUI/SplashScene
	# print(current_2d_scene)
	# print(current_3d_scene)
	# current_3d_scene = $World3D
	# current_2d_scene = $World2D
	# print(current_2d_scene)
	# print(current_3d_scene)

func change_3d_scene(
	new_scene: String,
	delete: bool = true,
	keep_running: bool = false,
	transition: bool = true,
	transition_in: String = "Fade In",
	transition_out: String = "Fade Out",
	seconds: float = 1.0
	) -> void:
	print("start change_3d_scene")
	if transition:
		transition_controller.transition(transition_out, seconds) # Transition Out
		await transition_controller.animation_player.animation_finished
		print("ayo")
	if current_3d_scene != null:
		if delete:
			current_3d_scene.queue_free() # remove node entirely
		elif keep_running:
			current_3d_scene.visible = false # keeps in memory and running
		else:
			world_3d.remove_child(current_3d_scene) # Keeps in memory does not run
	var new = load(new_scene).instantiate()
	world_3d.add_child(new) # load new scene
	current_3d_scene = new
	transition_controller.transition(transition_in, seconds) # Transition In
	print("end change_3d_scene")
	# GUI scene is still here
	# It never goes at the end of this func


func change_2d_scene(
	new_scene: String,
	delete: bool = true,
	keep_running: bool = false,
	transition: bool = true,
	transition_in: String = "Fade In",
	transition_out: String = "Fade Out",
	seconds: float = 1.0
	) -> void:
	if transition:
		transition_controller.transition(transition_out, seconds) # Transition Out
		await transition_controller.animation_player.animation_finished
	if current_2d_scene != null:
		if delete:
			current_2d_scene.queue_free() # remove node entirely
		elif keep_running:
			current_2d_scene.visible = false # keeps in memory and running
		else:
			world_2d.remove_child(current_2d_scene) # Keeps in memory does not run
	var new = load(new_scene).instantiate()
	world_2d.add_child(new) # load new scene
	current_2d_scene = new
	transition_controller.transition(transition_in, seconds) # Transition In

func change_gui_scene(
	new_scene: String,
	delete: bool = true,
	keep_running: bool = false,
	transition: bool = true,
	transition_in: String = "Fade In",
	transition_out: String = "Fade Out",
	seconds: float = 1.0
	) -> void:
	if transition:
		transition_controller.transition(transition_out, seconds) # Transition Out
		await transition_controller.animation_player.animation_finished
	if current_gui_scene != null:
		if delete:
			current_gui_scene.queue_free() # remove node entirely
		elif keep_running:
			#those it toggle if i need to comeback ??
			current_gui_scene.visible = false # keeps in memory and running
		else:
			# if i add the child back what happen
			gui.remove_child(current_gui_scene) # Keeps in memory does not run
	var new = load(new_scene).instantiate()
	gui.add_child(new) # load new scene
	current_gui_scene = new
	transition_controller.transition(transition_in, seconds) # Transition In

# i think change_ function need improvement further test to do
#"res://Scenes/UI/StageSelect.tscn"

func change_to_stage_select_scene() -> void:
	current_3d_scene.visible = false
	change_gui_scene("res://Scenes/UI/StageSelect.tscn")

	pass

func change_to_stage_scene(stage: String) -> void:
	pass