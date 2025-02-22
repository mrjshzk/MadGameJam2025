class_name Monster extends Node3D

@export var player: Player
@export var look_at: LookAtModifier3D
@export var hand_effector: GodotIKEffector

func _ready() -> void:
	look_at.target_node = player.target_node.get_path()

func _physics_process(delta: float) -> void:
	hand_effector.global_position = hand_effector.global_position.move_toward(player.target_node.global_position, delta * 5)
