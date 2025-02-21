class_name Player
extends CharacterBody3D

@export_category("Input")
@export var input_mapping_context: GUIDEMappingContext
@export var movement_definition: GUIDEAction
@export var interaction_definition: GUIDEAction

@export_category("Camera")
@export var camera: Camera

@export_category("Movement")
@export var walking_speed: float = 5.0

func _ready() -> void:
	camera.setup(self.rotation_degrees)
	GUIDE.enable_mapping_context(input_mapping_context)

func _physics_process(delta: float) -> void:
	var movement_direction: Vector3 = movement_definition.value_axis_3d
	
	if movement_direction == Vector3.ZERO:
		velocity = velocity.move_toward(Vector3.ZERO, min(1, delta * 20))
	else:
		velocity = transform.basis * movement_direction.normalized() * walking_speed
		
	move_and_slide()
	
