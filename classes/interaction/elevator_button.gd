class_name ElevatorButton
extends Interactable

@export var elevator: Elevator
@export var floor_to_go: Elevator.FLOOR_TYPE

@export var button_inner_mesh: MeshInstance3D

func on_start_interaction():
	disabled = true
	elevator.go_to_floor(floor_to_go)
	
	finished_interaction.emit()
