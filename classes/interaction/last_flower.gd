class_name LastFlower extends Interactable

@export var mesh: MeshInstance3D


func _ready() -> void:
	super()
	var level_3_manager : LevelObjectiveManager = get_tree()\
	.get_first_node_in_group("Level3")
	level_3_manager.register_objective(self)

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
