extends Control


@export var intro_scene: PackedScene

@export var play_button: Button
@export var options_button: Button
@export var quit_button: Button
@export var fade_out: ColorRect

func _ready() -> void:
	play_button.pressed.connect(on_play_pressed, CONNECT_ONE_SHOT)
	quit_button.pressed.connect(get_tree().quit)

func on_play_pressed():
	create_tween().tween_property(
		fade_out,
		"self_modulate",
		Color.WHITE,
		1.0
	).finished.connect(
		func():
			get_tree().change_scene_to_packed(intro_scene)
	)
