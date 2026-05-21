class_name Ennemy extends Node3D

# dye by jump on top of it
signal die
@export var hitBox: Area3D

func _ready():
    hitBox.area_entered.connect(_on_hitBox_area_entered)

func _on_hitBox_area_entered(area: Area3D):
    if area.name == "Player_Hitbox":
        die.emit()
        # sound effect
        # queue_free()


# some need to follow the player
# some need to flee
# Ia logic will be in a separate script