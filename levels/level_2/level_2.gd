extends Node3D

@export var level_mesh: MeshInstance3D
@export var level_manager: LevelObjectiveManager
@export var lightmap: LightmapGI
@export var multimeshes: Array[MultiMeshInstance3D]
@export var short_circuit_player: AudioStreamPlayer3D

func _ready() -> void:
	level_manager.objetive_just_completed.connect(on_completion)

var mat : StandardMaterial3D = preload("res://levels/materials/concrete_1/concrete_1.tres")
func on_completion():
	var elevator: Elevator = get_tree()\
	.get_first_node_in_group("Elevator")
	elevator.trigger_flicker()
	lightmap.hide()
	level_mesh.set_surface_override_material(0, mat)
	
	for multi in multimeshes:
		multi.gi_mode = GeometryInstance3D.GI_MODE_DISABLED
	short_circuit_player.play()
	
