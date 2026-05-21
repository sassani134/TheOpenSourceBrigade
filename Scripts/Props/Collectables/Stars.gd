extends Collectable

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
    pass

func _on_area_entered(area: Area3D) -> void:
    pass
