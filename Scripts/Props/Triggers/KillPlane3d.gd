extends Area3D


func _on_body_entered(body: Node3D) -> void:
	#Mouse contoller need to be givin back
	print(body)
	if body.has_group("Player"):
		Events.emit_signal("kill_plane_touched", body)
