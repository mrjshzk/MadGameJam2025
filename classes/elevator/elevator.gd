class_name Elevator extends Node3D

@export var player_inside := true

enum FLOOR_TYPE {
	FLOOR_1,
	FLOOR_2,
	FLOOR_3
}

@export var area: Area3D
@export var moving_player : AudioStreamPlayer3D
@export_group("Portas")
@export var close_player: AudioStreamPlayer3D
@export var open_player: AudioStreamPlayer3D
@export var door_r: MeshInstance3D
@export var door_l: MeshInstance3D

@onready var initial_door_r_z := door_r.position.z
@onready var initial_door_l_z := door_l.position.z

@export_group("Botoes")
@export var button_1: ElevatorButton
@export var button_2: ElevatorButton
@export var button_3: ElevatorButton

@onready var button_mapping : Dictionary[FLOOR_TYPE, ElevatorButton] = {
	FLOOR_TYPE.FLOOR_1: button_1,
	FLOOR_TYPE.FLOOR_2: button_2,
	FLOOR_TYPE.FLOOR_3: button_3,
}

var current_floor := FLOOR_TYPE.FLOOR_1

func go_to_floor(floor: FLOOR_TYPE):
	moving_player.play()
	await get_tree().create_timer(1.0, false).timeout
	create_tween()\
	.set_ease(Tween.EASE_IN_OUT)\
	.set_trans(Tween.TRANS_SINE)\
	.tween_property(self, "position:y", position.y + 10, 5.0)\
	.finished.connect(
		func():
			moving_player.stop()
			current_floor = floor
			await get_tree().create_timer(1.0, false).timeout
			open_doors()
			)

func _ready() -> void:
	area.body_entered.connect(_on_area_body_entered)
	area.body_exited.connect(_on_area_body_exited)
	allow_floor(FLOOR_TYPE.FLOOR_1)

func _on_area_body_entered(body: Node3D):
	if body is Player:
		close_doors()
		player_inside = true

func _on_area_body_exited(body: Node3D):
	if body is Player:
		print("played exited")
		player_inside = false

func open_and_allow_floor(floor: FLOOR_TYPE):
	allow_floor(floor)
	open_doors()

func open_doors():
	var t := create_tween()
	t.set_parallel(true)
	t.tween_property(door_r, "position:z", initial_door_r_z + 0.7, 1.0)
	t.tween_property(door_l, "position:z", initial_door_l_z - 0.7, 1.0)
	open_player.play()
	
func close_doors():
	var t := create_tween()
	t.set_parallel(true)
	t.tween_property(door_r, "position:z", initial_door_r_z, 1.0)
	t.tween_property(door_l, "position:z", initial_door_l_z, 1.0)
	close_player.play()

func allow_floor(floor: FLOOR_TYPE):
	for _floor in button_mapping.keys():
		if _floor == floor:
			button_mapping[_floor].disabled = false
		else:
			button_mapping[_floor].disabled = true
