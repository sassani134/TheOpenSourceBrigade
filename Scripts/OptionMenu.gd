extends Control

@onready var button: Button = $VBoxContainer/HBoxContainer/Button


func _on_button_pressed() -> void:
	Global.game_controller.change_gui_scene("res://Scenes/UI/TitleAndSystem/SelectFile.tscn")
