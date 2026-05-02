extends Node
# https://docs.godotengine.org/en/stable/classes/class_configfile.html


const CONFIG_PATH = "user://settings.cfg"

const DEFAULT_CONFIG_PATH: String = "res://Assets/default_settings.cfg"

const DEFAULT_VIDEO_SETTINGS: Dictionary = {
	"resolution": Vector2i(1280, 720),
	"fullscreen": false,
	"borderless": false,
	"vsync": true,
}

const DEFAULT_AUDIO_SETTINGS: Dictionary = {
	"volume_master": 100,
	"volume_music": 100,
	"volume_sfx": 100,
	"volume_voice": 100
}

# from project.godot input section

# l_trigger_2={
# "deadzone": 0.2,
# "events": [Object(InputEventJoypadMotion,"resource_local_to_scene":false,"resource_name":"","device":-1,"axis":4,"axis_value":1.0,"script":null)
# , Object(InputEventMouseButton,"resource_local_to_scene":false,"resource_name":"","device":-1,"window_id":0,"alt_pressed":false,"shift_pressed":false,"ctrl_pressed":false,"meta_pressed":false,"button_mask":0,"position":Vector2(0, 0),"global_position":Vector2(0, 0),"factor":1.0,"button_index":4,"canceled":false,"pressed":false,"double_click":false,"script":null)
# ]
# }

# cam_stick_up={
# "deadzone": 0.2,
# "events": [Object(InputEventKey,"resource_local_to_scene":false,"resource_name":"","device":-1,"window_id":0,"alt_pressed":false,"shift_pressed":false,"ctrl_pressed":false,"meta_pressed":false,"pressed":false,"keycode":0,"physical_keycode":4194443,"key_label":0,"unicode":53,"location":0,"echo":false,"script":null)
# , Object(InputEventJoypadMotion,"resource_local_to_scene":false,"resource_name":"","device":-1,"axis":3,"axis_value":-1.0,"script":null)
# ]
# }

# start_button={
# "deadzone": 0.2,
# "events": [Object(InputEventJoypadButton,"resource_local_to_scene":false,"resource_name":"","device":-1,"button_index":6,"pressure":0.0,"pressed":true,"script":null)
# ]
# }
# option_button={
# "deadzone": 0.2,
# "events": [Object(InputEventJoypadButton,"resource_local_to_scene":false,"resource_name":"","device":-1,"button_index":4,"pressure":0.0,"pressed":true,"script":null)
# ]
# }
# left_button={
# "deadzone": 0.2,
# "events": [Object(InputEventJoypadButton,"resource_local_to_scene":false,"resource_name":"","device":-1,"button_index":2,"pressure":0.0,"pressed":true,"script":null)
# ]
# }

# const ACTIONS = {
# 	"forward": "",
# 	"down": "",
# 	"left": "",
# 	"right": "",
# 	"jump": "",
# 	"crounch": "",
# 	"action_a": "",
# 	"start": "",
# }

const DEFAULT_CONTROLS_SETTINGS: Dictionary = {
	"cam_stick_left": "",
	"cam_stick_right": "",
	"cam_stick_up": "",
	"cam_stick_down": "",
	"cam_stick_deadzone": 0.2,
	"move_stick_left": "",
	"move_stick_right": "",
	"move_stick_up": "",
	"move_stick_down": "",
	"move_stick_deadzone": 0.2,
	"action_button_1": "",
	"action_button_2": "",
	"start_button": "",
	"option_button": "",
	"left_button": "",

}

const DEFAULT_MOBILE_CONTROLS_SETTINGS: Dictionary = {
	"mouvment_joystick_position": Vector2(200, 600),
	"camera_joystick_position": Vector2(1000, 600),
	"jump_button_position": Vector2(1500, 600),
}

const DEFAULT_LANGUAGE_SETTINGS: Dictionary = {
	"locale": "en",
}

var video_settings: Dictionary = {
	"resolution": Vector2i(1280, 720),
	"fullscreen": false,
	"borderless": false,
	"vsync": true,
}

var audio_settings: Dictionary = {
	"volume_master": 100,
	"volume_music": 100,
	"volume_sfx": 100,
	"volume_voice": 100
}

var controls_settings: Dictionary = {
	"cam_stick_left": "",
	"cam_stick_right": "",
	"cam_stick_up": "",
	"cam_stick_down": "",
	"cam_stick_deadzone": 0.2,
	"move_stick_left": "",
	"move_stick_right": "",
	"move_stick_up": "",
	"move_stick_down": "",
	"move_stick_deadzone": 0.2,
	"action_button_1": "",
	"action_button_2": "",
}

var mobile_controls_settings: Dictionary = {
	"mouvment_joystick_position": Vector2(200, 600),
	"camera_joystick_position": Vector2(1000, 600),
	"jump_button_position": Vector2(1500, 600),
	"action_button_1_position": Vector2(1500, 600),
	"action_button_2_position": Vector2(1500, 600),
}

var language_settings: Dictionary = {
	"locale": "en",
}

func _ready() -> void:
	load_settings()
	apply_video_settings()
	apply_audio_settings()
	apply_language_settings()
	return

func save_settings() -> void:
	var config: ConfigFile = ConfigFile.new()

	for key in video_settings:
		config.set_value("video", key, video_settings[key])

	for key in audio_settings:
		config.set_value("audio", key, audio_settings[key])
	
	for key in controls_settings:
		config.set_value("controls", key, controls_settings[key])
	
	for key in mobile_controls_settings:
		config.set_value("mobile_controls", key, mobile_controls_settings[key])
	
	for key in language_settings:
		config.set_value("language", key, language_settings[key])
	
	config.save(CONFIG_PATH)
	return

func load_settings() -> void:
	var config: ConfigFile = ConfigFile.new()
	var err := config.load(CONFIG_PATH)

	if err != OK:
		return
	for section in ["video", "audio", "controls", "mobile_controls", "language"]:
		if not config.has_section(section):
			continue
		
		var target_dict = get(section + "_settings")
		for key in target_dict.keys():
			if config.has_section_key(section, key):
				target_dict[key] = config.get_value(section, key)
	return

func apply_video_settings() -> void:
	var v = video_settings
	DisplayServer.window_set_vsync_mode(
	DisplayServer.VSYNC_ENABLED if v["vsync"] else DisplayServer.VSYNC_DISABLED
	)

	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if v["fullscreen"] else
		DisplayServer.WINDOW_MODE_WINDOWED
	)

	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, v["borderless"])
	DisplayServer.window_set_size(v["resolution"])
	return

func apply_audio_settings() -> void:
	var master_db = linear_to_db(clamp(audio_settings["volume_master"], 0.0, 1.0))
	var music_db = linear_to_db(clamp(audio_settings["volume_music"], 0.0, 1.0))
	var sfx_db = linear_to_db(clamp(audio_settings["volume_sfx"], 0.0, 1.0))
	var voice_db = linear_to_db(clamp(audio_settings["volume_voice"], 0.0, 1.0))

	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), master_db)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), music_db)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), sfx_db)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Voice"), voice_db)
	return


## need to see more video about controls
func apply_language_settings() -> void:
	TranslationServer.set_locale(language_settings["locale"])
	return

func apply_controls_settings() -> void:
	return

func apply_mobile_controls_settings() -> void:
	return

# need to see video about flag first time lauching game 
# factory reset settings
# Default reset
# Maybe 
# OS.get_locale_language() 
# FACTORY_RESET_SETTINGS()
# FACTORY_FLAG
#func _input(event):
# print(event.as_text())
