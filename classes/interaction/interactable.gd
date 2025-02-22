class_name Interactable extends StaticBody3D

signal finished_interaction
signal started_interaction

@export var interaction_time := 2.0

func _ready() -> void:
	started_interaction.connect(on_start_interaction)
	finished_interaction.connect(on_finished_interaction)

func on_start_interaction():
	print("starting interaction")
	get_tree().create_timer(interaction_time).timeout.connect(finished_interaction.emit)

func on_finished_interaction():
	print("finished")
