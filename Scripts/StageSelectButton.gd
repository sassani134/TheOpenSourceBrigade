class_name StageSelectButton extends Button

@export var stage: String
@export var new_scene: String

func _ready() -> void:
	print(SaveLoadManager.save_data["levels"]["level1"]["stagesNamed"][0])
