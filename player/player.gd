class_name Player
extends CharacterBody3D

#region Export Variables
@export_group("Input")
@export var input_mapping_context: GUIDEMappingContext
@export var movement_definition: GUIDEAction
@export var interaction_definition: GUIDEAction

@export_group("Camera")
@export var camera: Camera

@export_group("Movement")

@export var walking_speed: float = 5.0

@export_group("Interaction")
@export var interaction_manager: InteractionManager
@export var sway_manager: SwayManager
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
	GUIDE.enable_mapping_context(input_mapping_context)


func _physics_process(delta: float) -> void:
	if interaction_definition.value_bool == true:
		interaction_manager.try_start_interaction()
	
	var movement_direction: Vector3 = movement_definition.value_axis_3d
	
	if movement_direction == Vector3.ZERO:
		velocity = velocity.move_toward(Vector3.ZERO, min(1, delta * 20))
	else:
		velocity = transform.basis * movement_direction.normalized() * walking_speed
	
	move_and_slide()
	
	#region Debug
	if OS.has_feature("editor"):
		if Input.is_action_just_pressed("debug_toggle_input"):
			input_disabled = not input_disabled
		
		if Input.is_action_just_pressed("debug_quit"):
			get_tree().quit(0)
	#endregion

#region HelperFunctions
func disable_input():
	camera.stop_receiving_input = true
	sway_manager.disabled = true
	GUIDE.disable_mapping_context(input_mapping_context)
	velocity = Vector3.ZERO

func enable_input():
	camera.stop_receiving_input = false
	sway_manager.disabled = false
	GUIDE.enable_mapping_context(input_mapping_context)
#endregion
