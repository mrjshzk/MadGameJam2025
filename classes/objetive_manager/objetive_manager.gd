class_name LevelObjectiveManager extends Node

var elevator: Elevator

@export var next_floor: Elevator.FLOOR_TYPE
var interact_count : int = 0
var interaction_count_max : int = 0

signal objetive_just_completed


func _ready() -> void:
	elevator = get_tree().get_first_node_in_group("Elevator")
	elevator.close_area.body_exited.connect(initial_close_doors)

func initial_close_doors(body: Node3D):
	if is_objective_completed(): return
	if not body is Player: return
	elevator.close_doors()
	elevator.close_area.set_collision_mask_value(1, false)
	elevator.button_1.set_collision_layer_value(2, false)
	elevator.button_2.set_collision_layer_value(2, false)
	elevator.button_3.set_collision_layer_value(2, false)

func increase_count():
	interact_count += 1
	if is_objective_completed():
		objetive_just_completed.emit()
		elevator.open_and_allow_floor(next_floor)

func register_objective(interactable: Interactable):
	interaction_count_max += 1
	interactable.finished_interaction.connect(increase_count)

func is_objective_completed() -> bool:
	return interact_count == interaction_count_max
