class_name Collectable extends Area3D

func _ready() -> void:
    connect("body_entered", _on_body_entered)

func _on_body_entered(body: Node3D) -> void:
    print(body.get_name())
