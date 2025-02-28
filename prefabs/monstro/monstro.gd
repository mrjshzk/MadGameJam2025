class_name Monster extends Node3D

var player: Player
@export var look_at_modifier: LookAtModifier3D
@export var hand_effector: GodotIKEffector
@export var animation_player: AnimationPlayer

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	look_at_modifier.target_node = player.target_node.get_path()

var can_safely_trigger := false

func trigger_cutscene():
	can_safely_trigger = true
@onready var area_3d: Area3D = $MonsterSkeleton/HandAttachMent/Area3D

func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	if can_safely_trigger:
		animation_player.play("kill")
