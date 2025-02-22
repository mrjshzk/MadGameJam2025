@tool
extends StaticBody3D

@export var array_meshes: Array[ArrayMesh]
@export var flower_mesh: MeshInstance3D
@export var interactable: Interactable

@export_tool_button("Pick Random Flower!")
var pick_random := func():
	if array_meshes.is_empty():
		return
	current_mesh = array_meshes.pick_random()

var current_mesh: ArrayMesh:
	set(val):
		current_mesh = val
		flower_mesh.mesh = current_mesh

@export var register: bool = true
func _ready() -> void:
	if Engine.is_editor_hint() or not register: return
	var level_1_manager : LevelObjectiveManager = get_tree()\
	.get_first_node_in_group("Level1")
	level_1_manager.register_objective(interactable)
