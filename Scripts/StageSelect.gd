extends Control
# https://youtu.be/z6sUvOBYpT4 later

@onready var label_level_title: Label = $CenterContainer/VBoxContainer/LabelLevelTitle
@onready var h_box_container_stars: HBoxContainer = $CenterContainer/VBoxContainer/HBoxContainerStars
# @onready var label_stage_number: Label = $CenterContainer/VBoxContainer/LabelStageNumber
@onready var label_stage_name: Label = $CenterContainer/VBoxContainer/LabelStageName
@onready var label_stage_score: Label = $CenterContainer/VBoxContainer/LabelStageScore

var level_title: String
var scene_to_load: String

func _init(init_level_title: String = "level2") -> void:
	level_title = init_level_title


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
		for i in SaveLoadManager.save_data["levels"][level_title]["stagesNamed"]:
			print(i)
			var button: Button = Button.new()
			button.pressed.connect(_on_button_pressed.bind(button))
			button.text = i
			h_box_container_stars.add_child(button)
		label_stage_name.text = SaveLoadManager.save_data["levels"][level_title]["name"] # to change
		label_stage_score.text = str(SaveLoadManager.save_data["levels"][level_title]["coinsScore"])
	
	# match level_title:
	# 	"level1":
	# 		scene_to_load
	# 	"level2":
	# 		pass

	pass


func _on_button_pressed(stage_name: String) -> void:
	GameController.change_to_stage_scene(stage_name, level_title)
	pass
