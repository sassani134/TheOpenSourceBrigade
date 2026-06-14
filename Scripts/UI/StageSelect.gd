extends Control
# https://youtu.be/z6sUvOBYpT4 later

@onready var label_level_title: Label = $CenterContainer/VBoxContainer/LabelLevelTitle
@onready var h_box_container_stars: HBoxContainer = $CenterContainer/VBoxContainer/HBoxContainerStars
# @onready var label_stage_number: Label = $CenterContainer/VBoxContainer/LabelStageNumber
@onready var label_stage_name: Label = $CenterContainer/VBoxContainer/LabelStageName
@onready var label_stage_score: Label = $CenterContainer/VBoxContainer/LabelStageScore
@onready var button: Button = %Button
@onready var button_2: Button = %Button2
@onready var button_3: Button = %Button3
@onready var button_4: Button = %Button4
@onready var button_5: Button = %Button5
@onready var button_6: Button = %Button6

var level_title: String
var scene_to_load: String


# var levels: Dictionary[String, Variant] = {
# 	"level1": {
# 		"name": "Old MacDonald's farm",
# 		"discovered": false,
# 		"stars": 0,
# 		"stagesNamed": ["pig attck", "the quick brown fox", "the lazy dog", "Mary had a little lamb", "8 red coins"],
# 		"stagesCompleted": [false, false, false],
# 		"coinsScore": 0,
# 	},
# }

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	print("ayo" + str(SaveLoadManager.save_data["levels"][level_title]))
	if SaveLoadManager.save_data["levels"][level_title]:
		label_level_title.text = SaveLoadManager.save_data["levels"][level_title]["name"]
		# i will use the w/ carrousel later
		# use a for loop instead of this :/
		button.text = SaveLoadManager.save_data["levels"][level_title]["stagesNamed"][0]
		button_2.text = SaveLoadManager.save_data["levels"][level_title]["stagesNamed"][1]
		button_3.text = SaveLoadManager.save_data["levels"][level_title]["stagesNamed"][2]
		button_4.text = SaveLoadManager.save_data["levels"][level_title]["stagesNamed"][3]
		button_5.text = SaveLoadManager.save_data["levels"][level_title]["stagesNamed"][4]
		button_6.text = SaveLoadManager.save_data["levels"][level_title]["stagesNamed"][5]
		
		button.pressed.connect(_on_button_pressed.bind(SaveLoadManager.save_data["levels"][level_title]["stagesNamed"][0]))
		button_2.pressed.connect(_on_button_pressed.bind(SaveLoadManager.save_data["levels"][level_title]["stagesNamed"][1]))
		button_3.pressed.connect(_on_button_pressed.bind(SaveLoadManager.save_data["levels"][level_title]["stagesNamed"][2]))
		button_4.pressed.connect(_on_button_pressed.bind(SaveLoadManager.save_data["levels"][level_title]["stagesNamed"][3]))
		button_5.pressed.connect(_on_button_pressed.bind(SaveLoadManager.save_data["levels"][level_title]["stagesNamed"][4]))
		button_6.pressed.connect(_on_button_pressed.bind(SaveLoadManager.save_data["levels"][level_title]["stagesNamed"][5]))

		label_stage_name.text = SaveLoadManager.save_data["levels"][level_title]["name"] # to change
		label_stage_score.text = str(SaveLoadManager.save_data["levels"][level_title]["coinsScore"])
	
	# match level_title:
	# 	"level1":
	# 		scene_to_load
	# 	"level2":
	# 		pass

	pass

func _on_button_pressed(stage_name: String) -> void:
	# stage select scene to level scene hidden/remove 
	print(stage_name)
	# change String with a var
	Global.game_controller.change_to_stage_scene("res://Scenes/Worlds/1st_world.tscn", stage_name)
