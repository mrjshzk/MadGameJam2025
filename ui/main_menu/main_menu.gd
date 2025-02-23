extends Control



@export var play_button: Button
@export var options_button: Button
@export var quit_button: Button
@export var fade_out: ColorRect

func _ready() -> void:
	play_button.pressed.connect(on_play_pressed, CONNECT_ONE_SHOT)
	quit_button.pressed.connect(get_tree().quit)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	create_tween().tween_property(
		fade_out,
		"self_modulate",
		Color.TRANSPARENT,
		2.0
	)

func on_play_pressed():
	fade_out.color = Color.WHITE
	create_tween().tween_property(
		fade_out,
		"self_modulate",
		Color.WHITE,
		3.0
	).finished.connect(
		func():
			get_tree().change_scene_to_file("res://ui/intro/intro_scene.tscn")
	)
