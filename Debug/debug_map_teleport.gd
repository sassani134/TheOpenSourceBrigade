extends CSGTorus3D
@onready var area_3d: Area3D = $Area3D

@export var lvl: String = "level1"


func _ready() -> void:
	area_3d.body_entered.connect(_on_area_3d_body_entered)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		Global.game_controller.change_to_stage_select_scene(lvl)
		# la scene player n'est pas completement enlever
		#Global.game_controller.change_gui_scene()
