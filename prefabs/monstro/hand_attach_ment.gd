extends Area3D

func _ready() -> void:
	body_entered.connect(on_body_entered)

func on_body_entered(body: Node3D):
	if body is Player:
		(body as Player).damage_controller.trigger_animation()

func kill_player():
	var player : Player = get_tree().get_first_node_in_group("Player")
	player.damage_controller.trigger_animation()
