extends Control

@onready var label_level_name: Label = $VBoxContainer/LabelLevelName
@onready var label_stage_name: Label = $VBoxContainer/LabelStageName
@onready var label_coin_scores: Label = $VBoxContainer/LabelCoinScores

# doublon dans une instance ???
var level_text: String = "Placeholder"
var stage_text: String = "Placeholder"
var coin_text: String = "Placeholder"

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	$VBoxContainer/ButtonSave.pressed.connect(_on_button_save_pressed)
	$VBoxContainer/ButtonQuit.pressed.connect(_on_button_quit_to_main_menu)
	$VBoxContainer/ButtonContinue.pressed.connect(_on_button_continue_pressed)

	label_level_name.text = level_text
	label_stage_name.text = stage_text
	label_coin_scores.text = coin_text

func _on_button_save_pressed() -> void:
	SaveLoadManager._save(0)
	Global.game_controller.in_a_level = false
	Global.game_controller.change_3d_scene("res://Scenes/Worlds/hub_world.tscn")
	Global.game_controller.gui.queue_free()
	pass

func _on_button_continue_pressed() -> void:
	Global.game_controller.change_3d_scene("res://Scenes/Worlds/hub_world.tscn")
	Global.game_controller.in_a_level = false
	Global.game_controller.gui.queue_free()
	pass

func _on_button_quit_to_main_menu() -> void:
	Global.game_controller.change_gui_scene("res://Scenes/UI/TitleAndSystem/TitleScreen.tscn")
	Global.game_controller.in_a_level = false
	pass
