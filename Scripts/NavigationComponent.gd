extends Node3D
class_name NavigationComponent

@export var move_speed: float = 3.5
@export var rotation_speed: float = 10.0
@export var agent: NavigationAgent3D


func set_target(target_position: Vector3):
	agent.target_position = target_position

func get_next_direction(current_global_position: Vector3) -> Vector3:
	if agent.is_navigation_finished():
		return Vector3.ZERO
		
	var next_path_position = agent.get_next_path_position()
	var direction = (next_path_position - current_global_position).normalized()
	return direction

func is_target_reached() -> bool:
	return agent.is_navigation_finished()
