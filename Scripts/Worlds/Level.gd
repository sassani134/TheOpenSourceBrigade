class_name Level extends Node3D

var level_name: String = "Old MacDonald's farm"
var stage_selected: String
var star_names: Array[String]
var star_positions: Array[Vector3]
var star_enabled: Array[bool]
var score: int


@export var label3d: Label3D
@export var labelCoins: Label

func _ready() -> void:
	label3d.text = stage_selected

	
	# For each Stars in star array 
	# connect signals


# Old MacDonald's farm
# var levels: Dictionary[String, Variant] = {
# 	"level1": {
# 		"name": "Old MacDonald's farm",
# 		"discovered": false,
# 		"stars": 0,
# 		"stagesNamed": ["pig attck", "the quick brown fox", "the lazy dog", "Mary had a little lamb", "8 red coins", "placeholder"],
# 		"stagesCompleted": [false, false, false, false, false, false],
# 		"coinsScore": 0,
# 	},

# var save_data: Dictionary[String, Dictionary] = {
# 	"levels": levels,
# 	"misc": misc,
# 	"cinematics": cinematics,
# }


# stage_selected coordinates the star_enable list for the stars in the level
