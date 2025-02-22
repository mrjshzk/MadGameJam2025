class_name ElevatorButton
extends Interactable

@export var elevator: Elevator
@export var floor_to_go: Elevator.FLOOR_TYPE

@export var button_inner_mesh: MeshInstance3D

func on_start_interaction():
	disabled = true
	var t := create_tween()
	t.tween_property(button_inner_mesh, "position:z", 0.02, 0.2)
	t.tween_property(button_inner_mesh, "position:z", 0.0, 0.2)
	if elevator.current_floor == floor_to_go:
		print("same")
		elevator.open_doors()
	else:
		elevator.go_to_floor(floor_to_go)
	finished_interaction.emit()
