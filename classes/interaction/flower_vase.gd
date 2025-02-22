class_name VaseFlower extends Interactable

@export var mesh: MeshInstance3D

func on_start_interaction():
	super()
	disabled = true
	await get_tree().create_timer(0.4, false).timeout
	create_tween().tween_property(
		mesh,
		"scale",
		Vector3.ONE * 0.075,
		1.5
	)
