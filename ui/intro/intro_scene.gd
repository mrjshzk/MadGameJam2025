extends Control

@export var continue_button: TextureButton
@export var fader: ColorRect
var scene : AsyncScene
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
	continue_button.disabled = true
	fader.color = Color.BLACK
	create_tween().tween_property(
		fader,
		"self_modulate",
		Color.WHITE,
		2.5
	).finished.connect(
		func():
			scene = AsyncScene.new("res://levels/main/main_level.tscn", AsyncScene.LoadingSceneOperation.Additive)
			scene.OnComplete.connect(on_scene_load_complete)
	)

func on_scene_load_complete():
	self.queue_free()
	scene.ChangeScene()
