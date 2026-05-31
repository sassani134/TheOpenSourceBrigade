extends Control
# https://docs.godotengine.org/en/stable/tutorials/scripting/pausing_games.html

# i don't know if i it has to be in annother node
func _on_pause_button_pressed():
	get_tree().paused = true
	show()

func _on_button_resume_pressed() -> void:
	hide()
	get_tree().paused = false
	pass # Replace with function body.


func _on_button_leave_stage_pressed() -> void:
	pass # Replace with function body.
	# need an pop up to ask if i'm sure


func _on_button_quit_game_pressed() -> void:
	get_tree().quit()
	# need an pop up to ask if i'm sure


func _on_button_save_pressed() -> void:
	SaveLoadManager._save(1)
	# i need to have a var with the true slot
