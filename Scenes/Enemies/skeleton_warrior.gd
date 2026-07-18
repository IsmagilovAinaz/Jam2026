extends CharacterBody3D

@onready var nav_comp: NavigationComponent = $NavigationComponent
@export var gravity: float = 9.8
@export var followNode: Node3D = null

func _ready() -> void:
	nav_comp.set_target(followNode.global_position)

func _physics_process(delta):
	var direction = nav_comp.get_next_direction(global_position)
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	velocity.x = direction.x * nav_comp.move_speed
	velocity.z = direction.z * nav_comp.move_speed
	
	if direction.length() > 0.1:
		var target_rotation = atan2(direction.x, direction.z)
		rotation.y = lerp_angle(rotation.y, target_rotation, delta * nav_comp.rotation_speed)
		
	move_and_slide()
