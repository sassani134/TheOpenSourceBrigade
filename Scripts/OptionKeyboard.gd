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
	for child in f_buttons.get_children():
		if child is Button:
			child.text = str(child.shortcut.events.get(0).as_text_keycode())
	for child in number_buttons.get_children():
		if child is Button:
			child.text = str(child.shortcut.events.get(0).as_text_keycode())
	for child in alphabet_buttons.get_children():
		if child is Button:
			child.text = str(child.shortcut.events.get(0).as_text_keycode())
	for child in insert_buttons.get_children():
		if child is Button:
			child.text = str(child.shortcut.events.get(0).as_text_keycode())
	for child in kp_buttons.get_children():
		if child is Button:
			child.text = str(child.shortcut.events.get(0).as_text_keycode())

	
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

func _update_on_click_keyboard_button_albedo() -> void:
	pass

# Change albedo for button with action e.g forward = z to green
func _update_keyboard_button_albedo() -> void:
	pass
