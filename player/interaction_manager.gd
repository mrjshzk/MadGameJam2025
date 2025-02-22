class_name InteractionManager
extends RayCast3D

@export var player: Player
@export var animation_player: AnimationPlayer
@export var regador: MeshInstance3D

@export_group("Animation")
@export_subgroup("Interaction")
@export var particle_emitter: GPUParticles3D
@export var interaction_time := 0.5
@export var interaction_ease_type: Tween.EaseType = 0
@export var interaction_trans_type: Tween.TransitionType = 0
@export_subgroup("Audio")
@export var watering_player : AudioStreamPlayer3D

@export_subgroup("Return to Rest")
@export var return_time := 0.5
@export var return_ease_type: Tween.EaseType = 0
@export var return_trans_type: Tween.TransitionType = 0

@export_group("UI")
@export var hud: Control
@export var interactable_description: Label

func _physics_process(delta: float) -> void:
	if is_colliding():
		var collided_object : StaticBody3D = get_collider()
		if collided_object is Interactable:
			var interactable : Interactable = (collided_object as Interactable)
			if not interactable.disabled:
				hud.show()
				interactable_description.text = interactable.description
				return
	hud.hide()

func try_start_interaction() -> void:
	if is_colliding():
		var collided_object : StaticBody3D = get_collider()
		if collided_object is Interactable:
			var interactable : Interactable = (collided_object as Interactable)
			if not interactable.disabled:
				start_interaction(collided_object)

#region Helper Functions
func set_input_disabled(disabled: bool):
	player.input_disabled = disabled

enum POSE_TYPE {
	REST,
	INTERACT
}

var pose_mapping : Dictionary[POSE_TYPE, String] = {
	POSE_TYPE.REST: "rest_pose",
	POSE_TYPE.INTERACT: "interaction_pose",
}

func start_interaction(interactable: Interactable):
	set_input_disabled(true)
	if interactable.is_in_group("Regavel"):
		animate_interaction(interactable)
	interactable.finished_interaction.connect(func():
		set_input_disabled(false)
		if interactable.is_in_group("Regavel"):
			animate_return(), CONNECT_ONE_SHOT)
	interactable.started_interaction.emit()
	

func get_pose(pose_type: POSE_TYPE) -> Transform3D:
	var target_transform := Transform3D.IDENTITY
	var target_animation: Animation = animation_player.get_animation(pose_mapping.get(pose_type))
	var animation_position_track_index : int = target_animation.find_track("Camera/RegadorController/Sway/Regador:position", Animation.TYPE_VALUE)
	var target_position : Vector3 = target_animation.track_get_key_value(animation_position_track_index, 0)
	
	var animation_rotation_track_index : int = target_animation.find_track("Camera/RegadorController/Sway/Regador:rotation", Animation.TYPE_VALUE)
	var target_rotation : Vector3 = target_animation.track_get_key_value(animation_rotation_track_index, 0)
	
	target_transform.basis = Basis.from_euler(target_rotation)
	target_transform.origin = target_position
	return target_transform

func animate_interaction(collided_object: Interactable):
	var target_transform := get_pose(POSE_TYPE.INTERACT)
	var global_pose_pos := regador.to_global(target_transform.origin)
	var global_interaction_pos := collided_object.interaction_node_target.global_position
	target_transform.origin = global_interaction_pos
	
	var t := create_tween().set_parallel(true)
	t\
		.set_ease(interaction_ease_type)\
		.set_trans(interaction_trans_type)\
		.tween_property(
		regador,
		"global_position",
		global_interaction_pos,
		interaction_time
	)
	await t\
			.set_ease(interaction_ease_type)\
			.set_trans(interaction_trans_type)\
			.tween_property(
				regador,
				"basis",
				target_transform.basis,
				interaction_time
			).finished
	particle_emitter.emitting = true
	watering_player.play()

func animate_return():
	await create_tween()\
			.set_ease(return_ease_type)\
			.set_trans(return_trans_type)\
			.tween_property(
				regador,
				"transform",
				get_pose(POSE_TYPE.REST),
				return_time
			).finished
#endregion
