class_name DamageController
extends Control

@export var main_menu: PackedScene
@export var animation_player: AnimationPlayer

func trigger_animation():
	animation_player.play("OnHit")
	animation_player.animation_finished.connect(
		func(animation_name: String):
			if animation_name == "OnHit": return_to_main_menu()
			, CONNECT_ONE_SHOT
	)

func return_to_main_menu():
	get_tree().change_scene_to_packed(main_menu)
