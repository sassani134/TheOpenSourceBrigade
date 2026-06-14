- Global.gd
- GameController.gd
- SplashScreen.gd
- TitleScreen.gd
- SelectFile.gd
- hubWorld.gd
- StageSelect.gd
- Worlds.gd
- pause

```gdscript

# GameController.gd
func _ready() -> void:
	Global.game_controller = self
	current_gui_scene = $GUI/SplashScene

SplashScene
Global.game_controller.change_gui_scene("res://Scenes/UI/TitleAndSystem/TitleScreen.tscn")
SelectFile
func _on_button_file_1_pressed() -> void:
	#change 3d i guess and load or create save file 1 i guess
	SaveLoadManager._load(0)
	Global.game_controller.change_3d_scene("res://Scenes/Worlds/hub_world.tscn")
	Global.game_controller.current_gui_scene.queue_free()
	print("_on_button_file_1_pressed")

hubWorld / debug_map_teleporter
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		Global.game_controller.change_to_stage_select_scene(lvl)
		# la scene player n'est pas completement enlever
		#Global.game_controller.change_gui_scene()

StageSelect
func _on_button_pressed(stage_name: String) -> void:
	# stage select scene to level scene hidden/remove 
	print(stage_name)
	Global.game_controller.change_to_stage_scene("res://Scenes/Worlds/1st_world.tscn", stage_name)

Worlds pause
func _on_button_resume_pressed() -> void:
	hide()
	get_tree().paused = false
	pass # Replace with function body.

func _on_button_leave_stage_pressed() -> void:
	_on_button_resume_pressed()
	Global.game_controller.change_3d_scene("res://Scenes/Worlds/hub_world.tscn")
	# need an pop up to ask if i'm sure

hubWorld / debug_map_teleporter

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		Global.game_controller.change_to_stage_select_scene(lvl)
		# la scene player n'est pas completement enlever
		#Global.game_controller.change_gui_scene()

errors
```
# Cannot call method 'add_child' on a previously freed instance.

# ERROR: res: / / Scripts / UI / PauseMenu.gd: 40 - ParseError: Unexpectedidentifier"E0" in class body.

# E0: 00: 30: 655GameController.change_to_stage_select_scene: Cannotcallmethod'add_child'onapreviouslyfreedinstance.
#   < GDScriptSource > GameController.gd: 116@GameController.change_to_stage_select_scene()
#   < StackTrace > GameController.gd: 116@change_to_stage_select_scene()

#Quitter le stage puis retourner dans le stageselect depuis le hub world fait crash game

# stageselectscenen'est pas tres bien reload ou detruit


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
	gui.queue_free()
	world_3d.add_child(new) # load new scene
	current_3d_scene = new
	transition_controller.transition(transition_in, seconds) # Transition In


func _on_button_resume_pressed() -> void:
	hide()
	get_tree().paused = false
	pass # Replace with function body.

func _on_button_leave_stage_pressed() -> void:
	_on_button_resume_pressed()
	Global.game_controller.change_3d_scene("res://Scenes/Worlds/hub_world.tscn")
	# need an pop up to ask if i'm sure
	
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




	add gui = null after gui.queue_free()
	Cannot call method 'add_child' on a null value.
	
	E 0:01:12:816   GameController.change_to_stage_select_scene: Cannot call method 'add_child' on a null value.
	<GDScript Source>GameController.gd:98 @ GameController.change_to_stage_select_scene()
	<Stack Trace> GameController.gd:98 @ change_to_stage_select_scene()


Invalid access to property or key of type 'String' on a base object of type 'Dictionary[String, Nil]'.

print("ayo" + str(SaveLoadManager.save_data["levels"][level_title]))
E 0:00:26:772   _ready: Invalid access to property or key of type 'String' on a base object of type 'Dictionary[String, Nil]'.
  <GDScript Source>StageSelect.gd:33 @ _ready()
  <Stack Trace> StageSelect.gd:33 @ _ready()
                GameController.gd:95 @ change_to_stage_select_scene()
                debug_map_teleport.gd:12 @ _on_area_3d_body_entered()

----
```
Invalid assignment of property or key 'disabled' with value of type 'bool' on a base object of type 'null instance'.

E 0:00:08:737   PauseMenu.gd:20 @ _process(): Node not found: "%Button_leave_stage" (relative to "/root/GameController/World3D/HubWorld/Player3DDefault02/MobileHUD/PauseMenu").
  <C++ Error>   Method/function failed. Returning: nullptr
  <C++ Source>  scene/main/node.cpp:1963 @ get_node()
  <Stack Trace> PauseMenu.gd:20 @ _process()

E 0:00:08:737   _process: Invalid assignment of property or key 'disabled' with value of type 'bool' on a base object of type 'null instance'.
  <GDScript Source>PauseMenu.gd:20 @ _process()
  <Stack Trace> PauseMenu.gd:20 @ _process()
```0



E 0:00:24:242   GameController.change_to_result_screen: Cannot call method 'add_child' on a null value.
  <GDScript Source>GameController.gd:147 @ GameController.change_to_result_screen()
  <Stack Trace> GameController.gd:147 @ change_to_result_screen()

func change_to_result_screen(l: String, s: String, c: String) -> void:
	# if not gui or not is_instance_valid(gui):
	# 	gui = load("res://Scenes/UI/ResultScreen.tscn").instantiate()
	# 	add_child(gui)
	current_3d_scene.visible = false
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