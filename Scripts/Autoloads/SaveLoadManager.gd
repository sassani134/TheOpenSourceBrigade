extends Node


const FILE_PATH: String = "user://SaveFileName.json"
const SECURITY_KEY: String = "1230AZERTY"
const FILE_NAME: Array[String] = ["file_a", "file_b", "file_c", "file_d"]

# Old MacDonald Had a Farm
# Animal Farm
var levels: Dictionary[String, Variant] = {
	"level1": {
		"name": "Old MacDonald's farm",
		"discovered": false,
		"stars": 0,
		"stagesNamed": ["pig attck", "the quick brown fox", "the lazy dog", "Mary had a little lamb", "8 red coins", "placeholder"],
		"stagesCompleted": [false, false, false, false, false, false],
		"coinsScore": 0,
	},
	"level2": {
		"name": "The factory Runachier-Panner",
		"discovered": false,
		"stars": 0,
		"stagesNamed": ["Modern Times", "placeholder", "placeholder", "placeholder", "placeholder", "placeholder"],
		"stagesCompleted": [false, false, false, false, false, false],
		"coinsScore": 0,
	}
}

var misc: Dictionary[String, int] = {
	"collected_coins": 0,
	"enemies_killed": 0,
	"star_collected": 0,
	"died_count": 0,
	"time_played": 0,
}

var cinematics: Dictionary[StringName, bool] = {
	" cinematics_0": false,
	" cinematics_1": false,
	" cinematics_2": false,
	" cinematics_3": false,
	" cinematics_4": false,
}

var save_data: Dictionary[String, Dictionary] = {
	"levels": levels,
	"misc": misc,
	"cinematics": cinematics,
}

func _ready() -> void:
	print(save_data["misc"]["time_played"])
	return

func _save(slot: int) -> void:
	var file: FileAccess = FileAccess.open_encrypted_with_pass(FILE_PATH + FILE_NAME[slot], FileAccess.WRITE, SECURITY_KEY)
	file.store_var(save_data)
	file.close()
	return

func _load(slot: int) -> void:
	if FileAccess.file_exists(FILE_PATH + FILE_NAME[slot]):
		var file: FileAccess = FileAccess.open_encrypted_with_pass(FILE_PATH + FILE_NAME[slot], FileAccess.READ, SECURITY_KEY)
		var data: Dictionary = file.get_var()
		for i in data:
			if save_data.has(i):
				save_data[i] = data[i]
		file.close()
	return

# To access project resources once exported, it is recommended to use ResourceLoader instead of FileAccess

# get_access_time
# get_modified_time
