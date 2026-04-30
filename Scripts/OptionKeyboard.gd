extends Control


# ISO ANSI 
# https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Physical_keyboard_layouts_comparison_ANSI_ISO_%28fr%29.png/960px-Physical_keyboard_layouts_comparison_ANSI_ISO_%28fr%29.png
@onready var action_buttons_grid_container: GridContainer = %ActionButtonsGridContainer
#
@onready var forward_button: Button = $ActionButtonsGridContainer/ForwardButton
@onready var back_button: Button = $ActionButtonsGridContainer/BackButton
@onready var left_button: Button = $ActionButtonsGridContainer/LeftButton
@onready var right_button: Button = $ActionButtonsGridContainer/RightButton
@onready var jump_action_button: Button = $ActionButtonsGridContainer/JumpActionButton
@onready var crouch_button: Button = $ActionButtonsGridContainer/CrouchButton
@onready var action_a_button: Button = $ActionButtonsGridContainer/ActionAButton
@onready var start_button: Button = $ActionButtonsGridContainer/StartButton

# cam_stick_... Mouse
# move_stick_... Keyboard wasd physic key
# start_button = ???
# jump_button = Keyboard space
# crouch_button = Keyboard control
# action_a_button = Keyboard e

@onready var f_buttons: Control = %FButtons
@onready var number_buttons: Control = %NumberButtons
@onready var alphabet_buttons: Control = %AlphabetButtons
@onready var insert_buttons: Control = %InsertButtons
@onready var kp_buttons: Control = %kpButtons


const ACTIONS: Dictionary[String, String] = {
	"forward": "move_key_up",
	"down": "move_key_down",
	"left": "move_key_left",
	"right": "move_key_right",
	"jump": "jump_key",
	"crounch": "crounch_key",
	"action_a": "action_a_key",
	"start": "start_key",
}

var waitting_for_input: String = ""

func _ready() -> void:
	# for child in action_buttons_grid_container.get_children():
	# 	if child is Button:
	# 		child.pressed.connect()
	# forward_button.pressed.connect(.bind("forward"))
	# back_button.pressed.connect(.bind("back"))
	# left_button.pressed.connect(.bind("left"))
	# right_button.pressed.connect(.bind("right"))
	# jump_action_button.pressed.connect(.bind("jump"))
	# crouch_button.pressed.connect(.bind("crounch"))
	# action_a_button.pressed.connect(.bind("action_a"))
	# start_button.pressed.connect(.bind("start"))
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


func _get_action_button(instruction: String) -> Button:
	match instruction:
		"forward":
			return forward_button
		"back":
			return back_button
		"left":
			return left_button
		"right":
			return right_button
		"jump":
			return jump_action_button
		"crounch":
			return crouch_button
		"action_a":
			return action_a_button
		"start":
			return start_button
		_: # fallback if string doesn't match any case
			return null

func _get_keyboard_button(instruction: String) -> Button:
	return $KeyboardButton.get_node(instruction)

func _update_action_button_label(instruction: String) -> void:
	var action_name: String = ACTIONS[instruction]

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
