class_name InteractionManager
extends RayCast3D

@export var player: Player

func _physics_process(delta: float) -> void:
	if is_colliding():
		pass

#region HelperFunctions
func set_input(disable: bool):
	player.input_disabled = disable
#endregion
