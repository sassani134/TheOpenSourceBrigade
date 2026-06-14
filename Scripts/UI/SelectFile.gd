extends Control
# Change button text to save files names and data
@onready var button_file_1: Button = $CenterContainer/VBoxContainer/GridContainerSelectFile/ButtonFile1
@onready var button_file_2: Button = $CenterContainer/VBoxContainer/GridContainerSelectFile/ButtonFile2
@onready var button_file_3: Button = $CenterContainer/VBoxContainer/GridContainerSelectFile/ButtonFile3
@onready var button_file_4: Button = $CenterContainer/VBoxContainer/GridContainerSelectFile/ButtonFile4
@onready var button_copy: Button = $CenterContainer/VBoxContainer/HBoxContainer/ButtonCopy
@onready var button_erase: Button = $CenterContainer/VBoxContainer/HBoxContainer/ButtonErase
@onready var button_option: Button = $CenterContainer/VBoxContainer/HBoxContainer/ButtonOption

var score_selection_active: bool = false
var copy_mode: bool = false
var erase_mode: bool = false
var data_to_copy

# @onready var savefile_0: FileAccess = FileAccess.open(save_data,

# godot time played
# var start_time = OS.get_unix_time()
# var elapsed = OS.get_unix_time() - start_time
# var start_time = Time.get_unix_time_from_system()
# var elapsed = Time.get_unix_time_from_system() - start_time

func _ready() -> void:
	button_file_1.pressed.connect(_on_button_file_1_pressed)
	button_file_2.pressed.connect(_on_button_file_2_pressed)
	button_file_3.pressed.connect(_on_button_file_3_pressed)
	button_file_4.pressed.connect(_on_button_file_4_pressed)
	button_copy.toggled.connect(_on_button_copy_toggled)
	button_erase.toggled.connect(_on_button_erase_toggled)
	button_option.pressed.connect(_on_button_option_pressed)
	
	# i don't understand why star collected is still at zero
	if FileAccess.file_exists("user://file_a"):
		var data = SaveLoadManager._load_preview(0)
		button_file_1.text = "Stars: %s\n Times: %s\n Died: %s\n Last_time_play: %s" % [data[0], data[1], data[2], data[3]]
	else:
		# Theme overides icon color
		# button_file_1.Them
		button_file_1.text = "Empty File"
		

	if FileAccess.file_exists("user://file_b"):
		var data = SaveLoadManager._load_preview(1)
		button_file_2.text = "Stars: %s\n Times: %s\n Died: %s\n Last_time_play: %s" % [data[0], data[1], data[2], data[3]]
	else:
		button_file_2.text = "Empty File"

	if FileAccess.file_exists("user://file_c"):
		var data = SaveLoadManager._load_preview(2)
		button_file_3.text = "Stars: %s\n Times: %s\n Died: %s\n Last_time_play: %s" % [data[0], data[1], data[2], data[3]]
	else:
		button_file_3.text = "Empty File"
	if FileAccess.file_exists("user://file_d"):
		var data = SaveLoadManager._load_preview(3)
		button_file_4.text = "Stars: %s\n Times: %s\n Died: %s\n Last_time_play: %s" % [data[0], data[1], data[2], data[3]]
	else:
		button_file_4.text = "Empty File"
	

func _on_button_file_1_pressed() -> void:
	if copy_mode and data_to_copy != null: # change this to path
		print(data_to_copy)
		if data_to_copy == "user://file_a":
			print("this is already data to copy ")
			return
		copy_mode = false
		data_to_copy = null
	elif copy_mode:
		data_to_copy = "user://file_a"
	elif erase_mode:
		# confirm with a popup first
		DirAccess.remove_absolute("user://file_a") # be sure it is the right path
		self.text = "Empty File"
	else:
		SaveLoadManager.current_slot = 0
		SaveLoadManager._load(SaveLoadManager.current_slot)
		Global.game_controller.change_3d_scene("res://Scenes/Worlds/hub_world.tscn")
		Global.game_controller.current_gui_scene.queue_free()

func _on_button_file_2_pressed() -> void:
	if copy_mode and data_to_copy != null: # change this to path
		print(data_to_copy)
		if data_to_copy == "user://file_b":
			print("this is already data to copy ")
			return
		copy_mode = false
		data_to_copy = null
	elif copy_mode:
		data_to_copy = "user://file_b"
	elif erase_mode:
		# confirm with a popup first
		DirAccess.remove_absolute("user://file_b") # be sure it is the right path
		self.text = "Empty File"
	else:
		SaveLoadManager.current_slot = 1
		SaveLoadManager._load(SaveLoadManager.current_slot)
		Global.game_controller.change_3d_scene("res://Scenes/Worlds/hub_world.tscn")
		Global.game_controller.current_gui_scene.queue_free()

func _on_button_file_3_pressed() -> void:
	if copy_mode and data_to_copy != null: # change this to path
		print(data_to_copy)
		if data_to_copy == "user://file_c":
			print("this is already data to copy ")
			return
		copy_mode = false
		data_to_copy = null
	elif copy_mode:
		data_to_copy = "user://file_c"
	elif erase_mode:
		# confirm with a popup first
		DirAccess.remove_absolute("user://file_c") # be sure it is the right path
		self.text = "Empty File"
	else:
		SaveLoadManager.current_slot = 2
		SaveLoadManager._load(SaveLoadManager.current_slot)
		Global.game_controller.change_3d_scene("res://Scenes/Worlds/hub_world.tscn")
		Global.game_controller.current_gui_scene.queue_free()

func _on_button_file_4_pressed() -> void:
	print("_on_button_file_4_pressed")
	if copy_mode and data_to_copy != null: # change this to path
		print(data_to_copy)
		if data_to_copy == "user://file_d":
			print("this is already data to copy ")
			return
		copy_mode = false
		data_to_copy = null
	elif copy_mode:
		data_to_copy = "user://file_d"
	elif erase_mode:
		# confirm with a popup first
		DirAccess.remove_absolute("user://file_d") # be sure it is the right path
		self.text = "Empty File"
	else:
		SaveLoadManager.current_slot = 3
		SaveLoadManager._load(SaveLoadManager.current_slot)
		Global.game_controller.change_3d_scene("res://Scenes/Worlds/hub_world.tscn")
		Global.game_controller.current_gui_scene.queue_free()


func _on_button_copy_toggled(toggled_on: bool) -> void:
	# Copy save file to another save file
	# Global.game_controller.change_gui_scene("")
	print("toggle copy ", toggled_on)
	if toggled_on:
		copy_mode = true
		# change bg color
		erase_mode = false
		button_erase.set_pressed(false) # ?? i think i copilot this line
		$ColorRect.color = Color(0, 255, 0, 0.5)
	else:
		copy_mode = false
		$ColorRect.color = Color(255, 255, 255, 0.5)
	pass

func _on_button_erase_toggled(toggled_on: bool) -> void:
	# Erase save file
	# Global.game_controller.change_gui_scene("")
	print("toggle copy ", toggled_on)
	if toggled_on:
		erase_mode = true
		copy_mode = false
		button_copy.set_pressed(false)
		$ColorRect.color = Color(255, 0, 0, 0.5)
	else:
		erase_mode = false
		$ColorRect.color = Color(255, 255, 255, 0.5)
	pass

func _on_button_option_pressed() -> void:
	print("_on_button_option_pressed")
	# Global.game_controller.change_gui_scene("", false, true)
	pass
