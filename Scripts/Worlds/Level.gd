class_name Level extends Node3D

var stage_selected: String
var star_names: Array[String]
var star_positions: Array[Vector3]
var star_enabled: Array[bool]
var max_coins: int
var score: int

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


# stage_selected coordinates the star_enable list for the stars in the level
