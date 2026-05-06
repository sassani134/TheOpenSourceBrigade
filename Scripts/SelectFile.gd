extends Control

@onready var button_file_1: Button = $CenterContainer/VBoxContainer/GridContainerSelectFile/ButtonFile1
@onready var button_file_2: Button = $CenterContainer/VBoxContainer/GridContainerSelectFile/ButtonFile2
@onready var button_file_3: Button = $CenterContainer/VBoxContainer/GridContainerSelectFile/ButtonFile3
@onready var button_file_4: Button = $CenterContainer/VBoxContainer/GridContainerSelectFile/ButtonFile4
@onready var button_score: Button = $CenterContainer/VBoxContainer/HBoxContainer/ButtonScore
@onready var button_copy: Button = $CenterContainer/VBoxContainer/HBoxContainer/ButtonCopy
@onready var button_erase: Button = $CenterContainer/VBoxContainer/HBoxContainer/ButtonErase
@onready var button_option: Button = $CenterContainer/VBoxContainer/HBoxContainer/ButtonOption

var score_selection_active: bool = false
var copy_mode: bool = false
var erase_mode: bool = false

func _ready() -> void:
	button_file_1.pressed.connect(_on_button_file_1_pressed)
	button_file_2.pressed.connect(_on_button_file_2_pressed)
	button_file_3.pressed.connect(_on_button_file_3_pressed)
	button_file_4.pressed.connect(_on_button_file_4_pressed)
	button_score.pressed.connect(_on_button_score_pressed)
	button_copy.toggled.connect(_on_button_copy_toggled)
	button_erase.toggled.connect(_on_button_erase_toggled)
	button_option.pressed.connect(_on_button_option_pressed)

func _on_button_file_1_pressed() -> void:
	#change 3d i guess and load or create save file 1 i guess
	# Global.game_controller.change_3d_scene("")
	print("_on_button_file_1_pressed")
	pass

func _on_button_file_2_pressed() -> void:
	# Global.game_controller.change_3d_scene("")
	print("_on_button_file_2_pressed")
	pass

func _on_button_file_3_pressed() -> void:
	# Global.game_controller.change_3d_scene("")
	print("_on_button_file_3_pressed")
	pass

func _on_button_file_4_pressed() -> void:
	# Global.game_controller.change_3d_scene("")
	print("_on_button_file_4_pressed")
	pass

func _on_button_score_pressed() -> void:
	# Select a file 
	# Global.game_controller.change_gui_scene("")
	print("_on_button_score_pressed")
	pass

func _on_button_copy_toggled(toggled_on: bool) -> void:
	# Copy save file to another save file
	# Global.game_controller.change_gui_scene("")
	print("toggle copy ", toggled_on)
	if toggled_on:
		copy_mode = true
		erase_mode = false
		button_erase.set_pressed(false)
	else:
		copy_mode = false
	pass

func _on_button_erase_toggled(toggled_on: bool) -> void:
	# Erase save file
	# Global.game_controller.change_gui_scene("")
	print("toggle copy ", toggled_on)
	if toggled_on:
		erase_mode = true
		copy_mode = false
		button_copy.set_pressed(false)
	else:
		erase_mode = false
	pass

func _on_button_option_pressed() -> void:
	print("_on_button_option_pressed")
	# Global.game_controller.change_gui_scene("", false, true)
	pass
