class_name Level3
extends Node3D

@export var lightmap: LightmapGI
@export var level_mesh: MeshInstance3D
@export var multimeshes: Array[MultiMeshInstance3D]
@export var monstro: Monster

func _on_last_flower_finished_interaction() -> void:
	var mat_1 : StandardMaterial3D =\
	level_mesh.get_active_material(0)
	var mat_2 : StandardMaterial3D =\
	level_mesh.get_active_material(2)
	
	mat_1.emission_enabled = false
	mat_2.emission_enabled = false
	
	lightmap.hide()
	
	for multimesh in multimeshes:
		multimesh.gi_mode = GeometryInstance3D.GI_MODE_DISABLED
	
	await get_tree().create_timer(0.1, false).timeout
	var player : Player = get_tree()\
	.get_first_node_in_group("Player")
	player.disable_keyboard()
	monstro.show()
	monstro.trigger_cutscene()
