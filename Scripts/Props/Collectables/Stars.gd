extends Collectable

@export var lvl: String
@export var star_name: String
var star_position: Vector3
var star_enabled: bool = true


# signal star_collected(star_name)

# When grabed emit a signal to the level that it was grabed
# change SaveloadManager for this level and star name
# pass it to true so it save the star
# exit the level
# the display a modal that display the star collected the score coins and if you want to save or continue

func _ready() -> void:
	# SaveLoadManager notify if the star is collected
	# if the star is collected, then alter color to gray
	# Level
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	print("star _on_body_entered")
	# if body is CharacterBody3D:
	# Emit signal to level that the star is collected
	# change SaveLoadManager for this level and star name
	# pass it to true so it save the star
	# exit the level to the hub world
	if body.is_class("CharacterBody3D"):
		# emit_signal("star_collected", star_name)
		print(star_name)
		Events.emit_signal("star_collected", star_name, lvl)
		queue_free()
