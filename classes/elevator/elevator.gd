class_name Elevator extends Node3D

@export var player_inside := true

enum FLOOR_TYPE {
	FLOOR_1,
	FLOOR_2,
	FLOOR_3
}

@export var area: Area3D

func go_to_floor(floor: FLOOR_TYPE):
	pass

func _ready() -> void:
	area.body_entered.connect(_on_area_body_entered)
	area.body_exited.connect(_on_area_body_exited)

func _on_area_body_entered(body: Node3D):
	if body is Player:
		player_inside = true

func _on_area_body_exited(body: Node3D):
	if body is Player:
		player_inside = false
