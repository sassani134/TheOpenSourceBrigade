extends Control

@onready var f_buttons: Control = $FButtons
@onready var number_buttons: Control = $NumberButtons
@onready var alphabet_buttons: Control = $AlphabetButtons
@onready var insert_buttons: Control = $InsertButtons
@onready var kp_buttons: Control = $kpButtons
# ISO ANSI 
# https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Physical_keyboard_layouts_comparison_ANSI_ISO_%28fr%29.png/960px-Physical_keyboard_layouts_comparison_ANSI_ISO_%28fr%29.png

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

func _ready() -> void:
	#$AlphabetButtons/Button3.text = $AlphabetButtons/Button3.shortcut
	print(str($AlphabetButtons/Button3.shortcut.events))
	# [InputEventKey: keycode=90 (Z), mods=none, physical=false, location=unspecified, pressed=false, echo=false]
	$AlphabetButtons/Button3.text = str($AlphabetButtons/Button3.shortcut.events.get(0).as_text_keycode())
	pass
