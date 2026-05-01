extends Control


# ISO ANSI 
# https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Physical_keyboard_layouts_comparison_ANSI_ISO_%28fr%29.png/960px-Physical_keyboard_layouts_comparison_ANSI_ISO_%28fr%29.png
@onready var action_buttons_grid_container: GridContainer = %ActionButtonsGridContainer
#
# @onready var forward_button: Button = $ActionButtonsGridContainer/ForwardButton
# @onready var back_button: Button = $ActionButtonsGridContainer/BackButton
# @onready var left_button: Button = $ActionButtonsGridContainer/LeftButton
# @onready var right_button: Button = $ActionButtonsGridContainer/RightButton
# @onready var jump_action_button: Button = $ActionButtonsGridContainer/JumpActionButton
# @onready var crouch_button: Button = $ActionButtonsGridContainer/CrouchButton
# @onready var action_a_button: Button = $ActionButtonsGridContainer/ActionAButton
# @onready var start_button: Button = $ActionButtonsGridContainer/StartButton


@export var forward_button: Button
@export var back_button: Button
@export var left_button: Button
@export var right_button: Button
@export var jump_action_button: Button
@export var crouch_button: Button
@export var action_a_button: Button
@export var start_button: Button

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
	"back": "move_key_down",
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
	_update_action_button_labels()

	forward_button.pressed.connect(_on_rebind_action_button_pressed.bind("forward"))
	back_button.pressed.connect(_on_rebind_action_button_pressed.bind("back"))
	left_button.pressed.connect(_on_rebind_action_button_pressed.bind("left"))
	right_button.pressed.connect(_on_rebind_action_button_pressed.bind("right"))
	jump_action_button.pressed.connect(_on_rebind_action_button_pressed.bind("jump"))
	crouch_button.pressed.connect(_on_rebind_action_button_pressed.bind("crounch"))
	action_a_button.pressed.connect(_on_rebind_action_button_pressed.bind("action_a"))
	start_button.pressed.connect(_on_rebind_action_button_pressed.bind("start"))

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
	match direction:
		"forward": return forward_button
		"back": return back_button
		"left": return left_button
		"right": return right_button
		"jump": return jump_action_button
		"crounch": return crouch_button
		"action_a": return action_a_button
		"start": return start_button
		_: return null # fallback if string doesn't match any case
			

func _get_keyboard_button(instruction: String) -> Button:
	return $KeyboardButton.get_node(instruction)

func _update_action_button_label(direction: String) -> void:
	var action_name: String = ACTIONS[direction]
	var events := InputMap.action_get_events(action_name)

	var label_text: String = "Unassigned"

	if events.size() > 0:
		var event = events[0]
		if event is InputEventKey:
			if event.keycode != 0:
				label_text = OS.get_keycode_string(event.keycode)
	
	var btn = _get_action_button(direction)
	btn.text = label_text
	#btn.text = "ayos"


func _update_action_button_labels() -> void:
	for dir in ACTIONS.keys():
		print(dir)
		_update_action_button_label(dir)


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

func _on_rebind_action_button_pressed(direction: String):
	waitting_for_input = direction
	var btn := _get_action_button(direction)
	btn.text = "..."
	set_process_input(true)

func _on_rebind_keyboard_button_pressed(direction: String):
	pass

func _input(event: InputEvent) -> void:
	if waitting_for_input == "":
		return

	if event is InputEventKey and event.pressed:
		var direction = waitting_for_input
		var action_name = ACTIONS[direction]

		InputMap.action_erase_events(action_name)
		InputMap.action_add_event(action_name, event)

		_update_action_button_label(direction)

		waitting_for_input = ""
		set_process_input(false)
