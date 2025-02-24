extends Control

@export var continue_button: TextureButton
@export var fader: ColorRect

func _ready() -> void:
	FootstepTypeManager.current_type = FootstepTypeManager.TYPE.CONCRETE
	await get_tree().create_timer(1.0, false).timeout
	create_tween().tween_property(
		fader,
		"self_modulate",
		Color.TRANSPARENT,
		2.5
	)
	continue_button.pressed.connect(on_continue_pressed, CONNECT_ONE_SHOT)

func on_continue_pressed():
	fader.color = Color.BLACK
	create_tween().tween_property(
		fader,
		"self_modulate",
		Color.WHITE,
		2.5
	).finished.connect(
		func():
			get_tree().change_scene_to_file("res://ui/viewport/game_viewport.tscn")
	)
