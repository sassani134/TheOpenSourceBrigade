extends Collectable

signal coin_collected()
# play sounds
# change score
# queue_free()

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	if body.is_class("CharacterBody3D"):
		coin_collected.emit()
		queue_free()