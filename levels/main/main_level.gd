extends Node3D

@export var world_env: WorldEnvironment
func _input(event: InputEvent) -> void:
	if event.is_action("debug_plus_expo"):
		world_env.environment.tonemap_exposure += 0.05
	elif event.is_action("debug_minus_expo"):
		world_env.environment.tonemap_exposure -= 0.05
