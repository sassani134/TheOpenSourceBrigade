extends Control

@export_category("Sliders")
@export var master_slider: HSlider
@export var music_slider: HSlider
@export var sfx_slider: HSlider
@export var voice_slider: HSlider

@export_category("Buttons") # realy ?????
@export var master_button: Button
@export var music_button: Button
@export var sfx_button: Button
@export var voice_button: Button

const MIN_DB := -60.0
const MAX_DB := 0.0

func _ready() -> void:
	_sync_sliders()

	master_slider.value_changed.connect(_on_master_volume_changed)
	music_slider.value_changed.connect(_on_music_volume_changed)
	sfx_slider.value_changed.connect(_on_sfx_volume_changed)
	voice_slider.value_changed.connect(_on_voice_volume_changed)
	
	master_button.toggled.connect(_on_button_master_toggled)
	music_button.toggled.connect(_on_button_music_toggled)
	sfx_button.toggled.connect(_on_button_sfx_toggled)
	voice_button.toggled.connect(_on_button_voice_toggled)
	
	return

func _sync_sliders() -> void:
	master_slider.value = _db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	music_slider.value = _db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	sfx_slider.value = _db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	voice_slider.value = _db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Voice")))
	$CenterContainer/VBoxContainer/GridContainer/LabelMasterValue.text = str(int(_db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))))) + "%"
	$CenterContainer/VBoxContainer/GridContainer/LabelMusicValue.text = str(int(_db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))))) + "%" # "%d%%" % (music_slider.value * 100)
	$CenterContainer/VBoxContainer/GridContainer/LabelSFXValue.text = str(int(_db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))))) + "%"
	$CenterContainer/VBoxContainer/GridContainer/LabelVoiceValue.text = str(int(_db_to_slider(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Voice"))))) + "%"
	
	return


func _slider_to_db(value: float) -> float:
	if value <= 0.0:
		return MIN_DB
	
	var linear = value / 100.0
	var db = linear_to_db(linear)
	return clampf(db, MIN_DB, MAX_DB)

func _db_to_slider(db: float) -> float:
	if db <= MIN_DB:
		return .0
	var linear = db_to_linear(db)
	return clampf(linear * 100.0, .0, 100.0)

func _set_volume(bus_name: String, key: String, value: float) -> void:
	var db = _slider_to_db(value)
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, db)
	AudioServer.set_bus_mute(bus_index, db <= MIN_DB)

	var linear_value: float = clampf(value / 100.0, 0.0, 1.0)
	SettingsManager.audio_settings[key] = linear_value
	return

func _on_master_volume_changed(value: float) -> void:
	_set_volume("Master", "master_volume", value)
	$CenterContainer/VBoxContainer/GridContainer/LabelMasterValue.text = (str(int(value)) + "%")
	return

func _on_music_volume_changed(value: float) -> void:
	_set_volume("Music", "music_volume", value)
	$CenterContainer/VBoxContainer/GridContainer/LabelMusicValue.text = (str(int(value)) + "%")
	return

func _on_sfx_volume_changed(value: float) -> void:
	_set_volume("SFX", "sfx_volume", value)
	$CenterContainer/VBoxContainer/GridContainer/LabelSFXValue.text = (str(int(value)) + "%")
	return

func _on_voice_volume_changed(value: float) -> void:
	_set_volume("Voice", "voice_volume", value)
	$CenterContainer/VBoxContainer/GridContainer/LabelVoiceValue.text = (str(int(value)) + "%")
	return

func _on_button_master_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$CenterContainer/VBoxContainer/GridContainer/ButtonTestMaster/AudioStreamPlayer.play()
		print("Button Master Toggled ON")
	else:
		$CenterContainer/VBoxContainer/GridContainer/ButtonTestMaster/AudioStreamPlayer.stop()
		print("Button Master Toggled OFF")
	return

func _on_button_music_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$CenterContainer/VBoxContainer/GridContainer/ButtonTestMusic/AudioStreamPlayer.play()
		print("Button Music Toggled ON")
	else:
		$CenterContainer/VBoxContainer/GridContainer/ButtonTestMusic/AudioStreamPlayer.stop()
		print("Button Music Toggled OFF")
	return

func _on_button_sfx_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$CenterContainer/VBoxContainer/GridContainer/ButtonTestSFX/AudioStreamPlayer.play()
		print("Button SFX Toggled ON")
	else:
		$CenterContainer/VBoxContainer/GridContainer/ButtonTestSFX/AudioStreamPlayer.stop()
		print("Button SFX Toggled OFF")
	return

func _on_button_voice_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$CenterContainer/VBoxContainer/GridContainer/ButtonTestVoice/AudioStreamPlayer.play()
		print("Button Voice Toggled ON")
	else:
		$CenterContainer/VBoxContainer/GridContainer/ButtonTestVoice/AudioStreamPlayer.stop()
		print("Button Voice Toggled OFF")
	return
