class_name InteractionManager
extends RayCast3D

@export var player: Player

func try_start_interaction() -> void:
	if is_colliding():
		var collided_object : StaticBody3D = get_collider()
		player.input_disabled = true
		get_tree().create_timer(2.0, false).timeout.connect(func(): player.input_disabled = false)
