class_name Monster extends Node3D

var player: Player
@export var look_at: LookAtModifier3D
@export var hand_effector: GodotIKEffector
@export var animation_player: AnimationPlayer

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	look_at.target_node = player.target_node.get_path()

func trigger_cutscene():
	animation_player.play("kill")
