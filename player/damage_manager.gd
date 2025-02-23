class_name DamageManager
extends Node

@export var animation_player: AnimationPlayer

func trigger_animation():
	animation_player.play("OnHit")
	animation_player.animation_finished.connect(
		func(animation_name: String):
			if animation_name == "OnHit": return_to_main_menu()
			, CONNECT_ONE_SHOT
	)

func return_to_main_menu():
	get_tree().change_scene_to_file("res://ui/main_menu/scene/main_menu.tscn")
