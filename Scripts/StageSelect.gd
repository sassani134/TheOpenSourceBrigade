extends Control
# https://youtu.be/z6sUvOBYpT4 later

@onready var label_level_title: Label = $CenterContainer/VBoxContainer/LabelLevelTitle
@onready var h_box_container_stars: HBoxContainer = $CenterContainer/VBoxContainer/HBoxContainerStars
# @onready var label_stage_number: Label = $CenterContainer/VBoxContainer/LabelStageNumber
@onready var label_stage_name: Label = $CenterContainer/VBoxContainer/LabelStageName
@onready var label_stage_score: Label = $CenterContainer/VBoxContainer/LabelStageScore

var level_title: String = "level1"


func _init(init_level_title: String) -> void:
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
	if SaveLoadManager.save_data["levels"][level_title]:
		label_level_title.text = SaveLoadManager.save_data["levels"][level_title]["name"]
		# i will use the w/ carrousel later
		# var count: int = 0
		for i in SaveLoadManager.save_data["levels"][level_title]["stagesNamed"]:
			var button: Button = Button.new()
			button.text = i
			# SaveLoadManager.save_data["levels"]["level1"]["stagesNamed"][0]
			# button.pressed.connect(GameController.change_to_stage_scene(i, "res://Scenes/Worlds/1st_world.tscn"))
			button.pressed.connect(Callable(GameController, "change_to_stage_scene").bind(i, "res://Scenes/Worlds/1st_world.tscn"))
			h_box_container_stars.add_child(button)
		label_stage_name.text = SaveLoadManager.save_data["levels"][level_title]["name"] # to change
		label_stage_score.text = SaveLoadManager.save_data["levels"][level_title]["coinsScore"]
		# label_stage_number.text = "Stage " + level_title.substr(5, 1)
		# label_stage_name.text = SaveLoadManager.save_data["levels"][level_title]["name"]
		# label_stage_score.text = "Score: " + str(SaveLoadManager.save_data["levels"][level_title]["coinsScore"])
		# for i in range(3):
		# 	var star_texture_rect: TextureRect = h_box_container_stars.get_child(i) as TextureRect
		# 	if SaveLoadManager.save_data["levels"][level_title]["stars"] > i:
		# 		star_texture_rect.texture = load("res://Assets/Textures/star_full.png")
		# 	else:
		# 		star_texture_rect.texture = load("res://Assets/Textures/star_empty.png")
	pass
