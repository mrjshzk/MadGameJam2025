class_name DamageManager
extends Node

@export var animation_player: AnimationPlayer
var scene : AsyncScene
func trigger_animation():
	animation_player.play("OnHit")
	animation_player.animation_finished.connect(
		func(animation_name: String):
			if animation_name == "OnHit": return_to_main_menu()
			, CONNECT_ONE_SHOT
	)

func return_to_main_menu():
	scene = AsyncScene.new("res://ui/main_menu/scene/main_menu.tscn", AsyncScene.LoadingSceneOperation.Additive)
	scene.OnComplete.connect(on_scene_load_complete)

func on_scene_load_complete():
	var main_level: Node3D = get_tree().get_first_node_in_group("MainLevel")
	main_level.queue_free()
	scene.ChangeScene()
