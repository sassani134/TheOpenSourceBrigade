extends Area3D

func _ready() -> void:
	$Area3D.body_entered.connect(_on_area_entered)


func _on_area_entered(area: Area3D) -> void:
	get_tree().reload_current_scene()
