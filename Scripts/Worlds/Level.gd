class_name Level extends Node3D

var level_name: String = "Old MacDonald's farm"
var stage_selected: String
var star_names: Array[String]
var star_positions: Array[Vector3]
var star_enabled: Array[bool]
var score: int = 0


@export var label3d: Label3D
@export var labelCoins: Label

func _ready() -> void:
	Events.kill_plane_touched.connect(_on_kill_plane_touched)
	Events.star_collected.connect(_on_star_collected)
	
	label3d.text = stage_selected


func _on_kill_plane_touched() -> void:
	print("_on_kill_plane_touched")
	# reload current scene
	# add one to death count
	SaveLoadManager.save_data["misc"]["died_count"] += 1
	get_tree().reload_current_scene()


func _on_star_collected(star_name: String, lvl: String) -> void:
	print("_on_star_collected " + star_name + " " + lvl)
	# victory animation + sound	
	if star_name != null or star_name != "":
		var star_index = SaveLoadManager.save_data["levels"][lvl]["stagesNamed"].find(star_name)
		if SaveLoadManager.save_data["levels"][lvl]["stagesCompleted"][star_index]:
			print("star already collected")
		else:
			SaveLoadManager.save_data["levels"][lvl]["stagesCompleted"][star_index] = true
			SaveLoadManager.save_data["levels"][lvl]["stars"] += 1
			SaveLoadManager.save_data["misc"]["stars_collected"] = SaveLoadManager.save_data["misc"].get("stars_collected", 0) + 1
	Global.game_controller.change_to_result_screen(level_name, star_name, str(score))


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
