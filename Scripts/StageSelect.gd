extends Control

@onready var label_level_title: Label = $CenterContainer/VBoxContainer/LabelLevelTitle
@onready var h_box_container_stars: HBoxContainer = $CenterContainer/VBoxContainer/HBoxContainerStars
@onready var label_stage_number: Label = $CenterContainer/VBoxContainer/LabelStageNumber
@onready var label_stage_name: Label = $CenterContainer/VBoxContainer/LabelStageName
@onready var label_stage_score: Label = $CenterContainer/VBoxContainer/LabelStageScore

var level_title: String



func _init(init_level_title: String) -> void:
	level_title = init_level_title


func _ready() -> void:
	if SaveLoadManager.save_data["levels"][level_title]:
		label_level_title.text = SaveLoadManager.save_data["levels"][level_title]["name"]
		label_stage_number.text = "Stage " + level_title.substr(5, 1)
		label_stage_name.text = SaveLoadManager.save_data["levels"][level_title]["name"]
		label_stage_score.text = "Score: " + str(SaveLoadManager.save_data["levels"][level_title]["coinsScore"])
		for i in range(3):
			var star_texture_rect: TextureRect = h_box_container_stars.get_child(i) as TextureRect
			if SaveLoadManager.save_data["levels"][level_title]["stars"] > i:
				star_texture_rect.texture = load("res://Assets/Textures/star_full.png")
			else:
				star_texture_rect.texture = load("res://Assets/Textures/star_empty.png")
	pass


