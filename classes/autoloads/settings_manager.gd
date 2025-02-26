extends Node

var mouse_smoothing := true
var mouse_sens := 1.0

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
