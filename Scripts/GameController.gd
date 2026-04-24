class_name GameController extends Node

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

func change_3d_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_3d_scene != null:
		if delete:
			current_3d_scene.queue_free() # remove node entirely
		elif keep_running:
			current_3d_scene.visible = false # keeps in memory and running
		else:
			gui.remove_child(current_3d_scene) # Keeps in memory does not run
		var new = load(new_scene).instantiate()
		gui.add_child(new) # load new scene
		current_3d_scene = new
		
		
func change_2d_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_2d_scene != null:
		if delete:
			current_2d_scene.queue_free() # remove node entirely
		elif keep_running:
			current_2d_scene.visible = false # keeps in memory and running
		else:
			gui.remove_child(current_2d_scene) # Keeps in memory does not run
		var new = load(new_scene).instantiate()
		gui.add_child(new) # load new scene
		current_2d_scene = new

func change_gui_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_gui_scene != null:
		if delete:
			current_gui_scene.queue_free() # remove node entirely
		elif keep_running:
			current_gui_scene.visible = false # keeps in memory and running
		else:
			gui.remove_child(current_3d_scene) # Keeps in memory does not run
		var new = load(new_scene).instantiate()
		gui.add_child(new) # load new scene
		current_3d_scene = new
