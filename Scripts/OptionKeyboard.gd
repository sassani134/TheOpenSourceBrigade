extends Control


# ISO ANSI 
# https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Physical_keyboard_layouts_comparison_ANSI_ISO_%28fr%29.png/960px-Physical_keyboard_layouts_comparison_ANSI_ISO_%28fr%29.png
@onready var grid_container: GridContainer = %GridContainer
@onready var f_buttons: Control = %FButtons
@onready var number_buttons: Control = %NumberButtons
@onready var alphabet_buttons: Control = %AlphabetButtons
@onready var insert_buttons: Control = %InsertButtons
@onready var kp_buttons: Control = %kpButtons

const ACTIONS = {
	"forward": "",
	"down": "",
	"left": "",
	"right": "",
	"jump": "",
	"crounch": "",
	"action_a": "",
	"start": "",
}

var waitting_for_input: String = ""

func _ready() -> void:
	#$AlphabetButtons/Button3.text = $AlphabetButtons/Button3.shortcut
	print(str($AlphabetButtons/Button3.shortcut.events))
	# [InputEventKey: keycode=90 (Z), mods=none, physical=false, location=unspecified, pressed=false, echo=false]
	$AlphabetButtons/Button3.text = str($AlphabetButtons/Button3.shortcut.events.get(0).as_text_keycode())
	pass

# click on "action button" = choose an input
# click on "keyboard button" = choose an action


func _get_action_button(direction: String) -> Button:
	return $ActionButtons.get_node(direction)

func _get_keyboard_button(direction: String) -> Button:
	return $KeyboardButton.get_node(direction)

func _update_action_button_label() -> void:
	pass

func _update_keyboard_buttons_label() -> void:
	pass

# Change albedo of "waitting for input" button to red
func _update_waitting_for_input_keyboard_button_albedo() -> void:
	pass

# change albedo for button with action e.g forward = z to green
func _update_keyboard_button_albedo() -> void:
	pass
