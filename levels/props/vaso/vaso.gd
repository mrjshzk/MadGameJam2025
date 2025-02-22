@tool
extends StaticBody3D

@export var array_meshes: Array[ArrayMesh]
@export var flower_mesh: MeshInstance3D

@export_tool_button("Pick Random Flower!")
var pick_random := func():
	if array_meshes.is_empty():
		return
	current_mesh = array_meshes.pick_random()

var current_mesh: ArrayMesh:
	set(val):
		current_mesh = val
		flower_mesh.mesh = current_mesh
