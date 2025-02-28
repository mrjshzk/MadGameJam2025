extends Node

var mouse_smoothing := true:
	set(val):
		mouse_smoothing = val
		mouse_smoothing_toggled.emit(val)

var mouse_sens := 1.0:
	set(val):
		mouse_sens = val
		mouse_sens_changed.emit(val)

var master_vol := AudioServer.get_bus_volume_linear(0):
	set(val):
		AudioServer.set_bus_volume_linear(0, val)
		master_vol = val
		
var music_vol := AudioServer.get_bus_volume_linear(1):
	set(val):
		AudioServer.set_bus_volume_linear(1, val)
		music_vol = val

signal mouse_sens_changed(value: float)
signal mouse_smoothing_toggled(disabled: bool)

@onready var cache_mats : Array[StandardMaterial3D] = [
	preload("res://levels/materials/light_mat.tres"),
	preload("res://levels/materials/light_mat_2.tres"),
	preload("res://levels/materials/interior_light_mat.tres"),
]
