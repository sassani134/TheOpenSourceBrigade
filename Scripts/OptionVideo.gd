extends Control

@export_category("Video")
@export var resolution_option: OptionButton
@export var fullscreen_option: CheckBox
@export var borderless_option: CheckBox
@export var vsync_option: CheckBox

func _ready() -> void:
	var resolutions : Array[Vector2i] = [
		Vector2i(1920,1080),
		Vector2i(1600,900),
		Vector2i(1280,720),
		Vector2i(640,360),
		Vector2i(320,180)
	]
	
	for res in resolutions:
		resolution_option.add_item("%dx%d" % [res.x, res.y])
	
	load_current_settings()
	
	resolution_option.item_selected.connect(_on_resolution_selected)


func load_current_settings() -> void:
	pass

func _on_resolution_selected(index: int) -> void:
	pass

func _on_fullscreen_toggled(enabled: bool) -> void:
	pass
	
func _on_borderless_toggled(enabled: bool) -> void:
	pass

func _on_vsync_toggled(enabled: bool) -> void:
	pass
