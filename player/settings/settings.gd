class_name PauseMenu extends Control

@export var player: Player

@export var resume_button: Button
@export var quit_button: Button

@export var smoothing_checkbox: CheckBox
@export var sensitivity: HSlider

@export var music_volume: HSlider
@export var master_volume: HSlider

func _ready() -> void:
	smoothing_checkbox.button_pressed = SettingsManager.mouse_smoothing
	sensitivity.value = SettingsManager.mouse_sens
	music_volume.value = SettingsManager.music_vol
	master_volume.value = SettingsManager.master_vol
	resume_button.pressed.connect(
		func():
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			self.hide()
			GUIDE.enable_mapping_context(player.input_mapping_context)
			get_tree().paused = false
	)
	
	quit_button.pressed.connect(get_tree().quit.bind(0))
	
	smoothing_checkbox.toggled.connect(
		func(val: bool):
			SettingsManager.mouse_smoothing_toggled.emit(val)
	)
	
	sensitivity.value_changed.connect(
		func(val: float):
			SettingsManager.mouse_sens_changed.emit(val)
	)
	
	music_volume.value_changed.connect(
		func(val: float):
			SettingsManager.music_vol = val
	)
	
	master_volume.value_changed.connect(
		func(val: float):
			SettingsManager.master_vol = val
	)
