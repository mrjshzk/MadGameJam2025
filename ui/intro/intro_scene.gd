extends Control

@export var game_scene: PackedScene
@export var continue_button: Button
@export var fader: ColorRect

func _ready() -> void:
	create_tween().tween_property(
		fader,
		"self_modulate",
		Color.TRANSPARENT,
		1.0
	)
	continue_button.pressed.connect(on_continue_pressed, CONNECT_ONE_SHOT)

func on_continue_pressed():
	create_tween().tween_property(
		fader,
		"self_modulate",
		Color.WHITE,
		1.0
	).finished.connect(
		func():
			get_tree().change_scene_to_packed(game_scene)
	)
