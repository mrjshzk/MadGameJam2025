class_name Player
extends CharacterBody3D

#region Export Variables
@export_group("Input")
@export var input_mapping_context: GUIDEMappingContext
@export var movement_definition: GUIDEAction
@export var interaction_definition: GUIDEAction
@export var pause_definition: GUIDEAction
@export var pause_menu: PauseMenu

@export_group("Camera")
@export var camera: Camera

@export_group("Movement")

@export var walking_speed: float = 5.0

@export_group("Interaction")
@export var interaction_manager: InteractionManager
@export var sway_manager: SwayManager

@export_group("Footsteps")
@export var footstep_player: AudioStreamPlayer3D
@export var footstep_timer: Timer
@export var dirt_sounds: Array[AudioStream]
@export var concrete_sounds: Array[AudioStream]

@export_group("IK helper")
@export var target_node : Node3D
@export var damage_controller: DamageManager
#endregion

var input_disabled: bool = false:
	set(val):
		if val:
			disable_input()
		else:
			enable_input()
		input_disabled = val

func _ready() -> void:
	camera.setup(self.rotation_degrees)

func _physics_process(delta: float) -> void:
	if interaction_definition.value_bool == true:
		interaction_manager.try_start_interaction()
	
	var movement_direction: Vector3 = movement_definition.value_axis_3d
	
	if movement_direction == Vector3.ZERO:
		if not footstep_timer.is_stopped():
			footstep_timer.stop()
		velocity = velocity.move_toward(Vector3.ZERO, min(1, delta * 20))
	else:
		if footstep_timer.is_stopped():
			footstep_timer.start()
		velocity = transform.basis * movement_direction.normalized() * walking_speed
	
	if not is_on_floor():
		velocity.y -= 16
	
	move_and_slide()
	
	if pause_definition.value_bool:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		pause_menu.show()
		pause_menu.resume_button.grab_focus()
		GUIDE.disable_mapping_context(input_mapping_context)
		get_tree().paused = true

#region HelperFunctions
func disable_input():
	camera.stop_receiving_input = true
	disable_keyboard()

func disable_keyboard():
	sway_manager.disabled = true
	GUIDE.disable_mapping_context(input_mapping_context)
	velocity = Vector3.ZERO

func enable_input():
	camera.stop_receiving_input = false
	sway_manager.disabled = false
	GUIDE.enable_mapping_context(input_mapping_context)
#endregion

func _on_footstep_timer_timeout() -> void:
	if FootstepTypeManager.current_type == FootstepTypeManager.TYPE.CONCRETE:
		footstep_player.stream = concrete_sounds.pick_random()
	else:
		footstep_player.stream = dirt_sounds.pick_random()
	footstep_player.pitch_scale = randf_range(0.9, 1.1)
	footstep_player.play()
