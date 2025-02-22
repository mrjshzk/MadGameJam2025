class_name DirtSwitcher
extends Area3D

func _ready() -> void:
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)

func on_body_entered(body: Node3D):
	if body is Player:
		FootstepTypeManager.current_type = FootstepTypeManager.TYPE.DIRT
		
func on_body_exited(body: Node3D):
	if body is Player:
		FootstepTypeManager.current_type = FootstepTypeManager.TYPE.CONCRETE
