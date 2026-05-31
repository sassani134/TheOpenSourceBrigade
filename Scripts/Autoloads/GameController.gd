class_name GameController extends Node
# https://docs.godotengine.org/en/stable/tutorials/scripting/change_scenes_manually.html
# [The SMART Way to Manage Scenes in Godot](https://youtu.be/32h8BR0FqdI)

@onready var transition_controller: SceneTransitionController = $TransitionController

@export var world_3d: Node3D
@export var world_2d: Node2D
@export var gui: Control


var current_3d_scene: Node3D
var current_2d_scene: Node2D
# Maybe an array ???
var current_gui_scene: Control # main menu, HUD, etc


# Should i add 

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
	if transition:
		transition_controller.transition(transition_out, seconds) # Transition Out
		await transition_controller.animation_player.animation_finished
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


func change_to_stage_select_scene(level: String) -> void:
	# SaveLoadManager.save_data["levels"][stage]["starNamed"]
	current_3d_scene.visible = false
	transition_controller.transition("Fade Out", 1.0)
	await transition_controller.animation_player.animation_finished
	var new = load("res://Scenes/UI/StageSelect.tscn").instantiate()
	new.level_title = level
	gui.add_child(new) # load new scene
	current_gui_scene = new
	transition_controller.transition("Fade In", 1.0) # Transition In


func change_to_stage_scene(
	new_scene: String,
	stage: String,
	position: Vector3 = Vector3.ZERO,
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
	if current_3d_scene != null:
		if delete:
			current_3d_scene.queue_free() # remove node entirely
		elif keep_running:
			current_3d_scene.visible = false # keeps in memory and running
		else:
			world_3d.remove_child(current_3d_scene) # Keeps in memory does not run
	var new = load(new_scene).instantiate()
	# new.character_start_position = position
	new.stage_selected = stage
	gui.queue_free()
	world_3d.add_child(new) # load new scene
	current_3d_scene = new
	transition_controller.transition(transition_in, seconds) # Transition In


func add_player_to_level() -> void:
	var new = load("res://Scenes/Player/player.tscn").instantiate()
	world_3d.add_child(new) # load new scene
	current_3d_scene = new
	
func flush_player(keep_running: bool = true, hide_player: bool = false, delete: bool = false) -> void:
	if current_3d_scene != null:
		if keep_running:
			current_3d_scene.queue_free() # remove node entirely
		elif hide_player:
			current_3d_scene.visible = false # keeps in memory and running
		else:
			world_3d.remove_child(current_3d_scene) # Keeps in memory does not run
	current_3d_scene = null
	pass
