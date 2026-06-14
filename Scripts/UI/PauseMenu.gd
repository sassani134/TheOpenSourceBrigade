extends Control
# https://docs.godotengine.org/en/stable/tutorials/scripting/pausing_games.html

# do not forget to change music

#current_3d_scene: HubWorld:<Node3D#97643398741>


func _ready() -> void:
	#if Global.game.level_name == " Old MacDonald's farm" or Global.game.level_name == "DemoDebugWorld":
		#%Button_leave_stage.disabled = true
		pass

func _process(delta: float) -> void:
	# not the best practise but it works for now 
	# and it's a pause menu so it doesn't really matter
	# if Global.game_controller.in_a_level:
	# 	$%Button_leave_stage.disabled = false
	# else:
	# 	$%Button_leave_stage.disabled = true
	pass

# i don't know if i it has to be in annother node
func _on_pause_button_pressed():
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	show()

func _on_button_resume_pressed() -> void:
	hide()
	get_tree().paused = false
	pass # Replace with function body.


func _on_button_leave_stage_pressed() -> void:
	if Global.game_controller.in_a_level == true:
		_on_button_resume_pressed()
		Global.game_controller.in_a_level = false
		Global.game_controller.change_3d_scene("res://Scenes/Worlds/hub_world.tscn")
	else:
		print("Already in hub world")
	pass
	# Global.game_controller.in_a_level = false
	# need an pop up to ask if i'm sure


func _on_button_quit_game_pressed() -> void:
	# Global.game_controller.in_a_level = false
	get_tree().quit()
	# need an pop up to ask if i'm sure


func _on_button_save_pressed() -> void:
	SaveLoadManager._save(SaveLoadManager.current_slot)

	# had an animation here
	# had sounds
	# i need to have a var with the true slot


func _on_button_go_back_file_select_pressed() -> void:
	Global.game_controller.change_gui_scene("res://Scenes/UI/FileSelect.tscn")
	Global.game_controller.in_a_level = false
	Global.game_controller.current_3d_scene.queue_free()
	Global.game_controller.current_3d_scene = null

func _on_button_print_save_pressed() -> void:
	print(SaveLoadManager.save_data)
