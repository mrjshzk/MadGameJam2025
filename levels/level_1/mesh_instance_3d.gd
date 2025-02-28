extends MeshInstance3D

func _ready() -> void:
	get_tree().create_timer(0.2).timeout.connect(set_mat)

func set_mat():
	self.mesh.surface_set_material(0, SettingsManager.cache_mats[0])
