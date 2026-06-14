class_name GameController extends Node
# https://docs.godotengine.org/en/stable/tutorials/scripting/change_scenes_manually.html
# [The SMART Way to Manage Scenes in Godot](https://youtu.be/32h8BR0FqdI)

@onready var transition_controller: SceneTransitionController = $TransitionController

@export var world_3d: Node3D
@export var world_2d: Node2D
@export var gui: Control

var current_3d_scene: Node3D # add getter method ?
var current_2d_scene: Node2D
var current_gui_scene: Control
var in_a_level: bool = false


func _ready() -> void:
	Global.game_controller = self
	current_gui_scene = $GUI/SplashScene


func change_3d_scene(new_scene: String, delete: bool = true, keep_running: bool = false,
	transition: bool = true, transition_in: String = "Fade In", transition_out: String = "Fade Out",
	seconds: float = 1.0) -> void:
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
	print("current_3d_scene: ", current_3d_scene)


func change_2d_scene(new_scene: String, delete: bool = true, keep_running: bool = false,
	transition: bool = true, transition_in: String = "Fade In", transition_out: String = "Fade Out",
	seconds: float = 1.0) -> void:
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
	print("current_2d_scene: ", current_2d_scene)


func change_gui_scene(new_scene: String, delete: bool = true, keep_running: bool = false,
	transition: bool = true, transition_in: String = "Fade In", transition_out: String = "Fade Out",
	seconds: float = 1.0) -> void:
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
	print("current_gui_scene: ", current_gui_scene)


# i think change_ function need improvement further test to do
#"res://Scenes/UI/StageSelect.tscn"


func change_to_stage_select_scene(level: String) -> void:
	# SaveLoadManager.save_data["levels"][stage]["starNamed"]
	if not gui or not is_instance_valid(gui):
		gui = load("res://Scenes/UI/StageSelect.tscn").instantiate()
		gui.level_title = level
		add_child(gui)

	current_3d_scene.visible = false
	transition_controller.transition("Fade Out", 1.0)
	await transition_controller.animation_player.animation_finished
	var new = load("res://Scenes/UI/StageSelect.tscn").instantiate()
	new.level_title = level
	gui.add_child(new) # load new scene
	current_gui_scene = new
	transition_controller.transition("Fade In", 1.0) # Transition In
	print("current_gui_scene: ", current_gui_scene)


func change_to_stage_scene(new_scene: String, stage: String, position: Vector3 = Vector3.ZERO,
	delete: bool = true, keep_running: bool = false,
	transition: bool = true, transition_in: String = "Fade In", transition_out: String = "Fade Out",
	seconds: float = 1.0) -> void:
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
	if gui != null:
		gui.queue_free()
		gui = null
	world_3d.add_child(new) # load new scene
	current_3d_scene = new
	transition_controller.transition(transition_in, seconds) # Transition In
	in_a_level = true
	print("current_3d_scene: ", current_3d_scene)


# change_to_result_screen


func old_change_to_result_screen(l: String, s: String, c: String) -> void:
	# if not gui or not is_instance_valid(gui):
	# 	gui = load("res://Scenes/UI/ResultScreen.tscn").instantiate()
	# 	add_child(gui)
	current_3d_scene.queue_free()
	transition_controller.transition("Fade Out", 1.0)
	await transition_controller.animation_player.animation_finished
	var new = load("res://Scenes/UI/ResultScreen.tscn").instantiate()
	new.level_text = l
	new.stage_text = s
	new.coin_text = c
	gui.add_child(new) # load new scene
	current_gui_scene = new
	transition_controller.transition("Fade In", 1.0) # Transition In
	print("current_gui_scene: ", current_gui_scene)

func change_to_result_screen(l: String, s: String, c: String) -> void:
	# Transition out
	# I want star transition not ready yet
	transition_controller.transition("Fade Out", 1.0)
	await transition_controller.animation_player.animation_finished
	
	# Nettoyer l'ancienne scène 3D
	if current_3d_scene != null:
		current_3d_scene.queue_free()
	
	# Supprimer l'ancien GUI s'il existe
	if current_gui_scene != null:
		current_gui_scene.queue_free()

# S'assurer que gui existe
	gui = load("res://Scenes/UI/ResultScreen.tscn").instantiate()
	gui.level_text = l
	gui.stage_text = s
	gui.coin_text = c
	add_child(gui)


	current_gui_scene = gui
	
	# Transition in
	transition_controller.transition("Fade In", 1.0)
	print("current_gui_scene: ", current_gui_scene)

	# var new = load(new_scene).instantiate()
	# gui.add_child(new) # load new scene
	# current_gui_scene = new
	# transition_controller.transition(transition_in, seconds) # Transition In
	# print("current_gui_scene: ", current_gui_scene)