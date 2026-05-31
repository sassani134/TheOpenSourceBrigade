class_name Collectable extends Area3D
signal collected()

func _ready() -> void:
    add_to_group("Collectable")


func _on_body_entered(body: Node3D) -> void:
    if body.has_group("Player"):
        collected.emit()
        queue_free()
