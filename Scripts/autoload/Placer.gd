extends Node3D

@onready var tower = preload("res://Scenes/Towers/tower_1.tscn")

var camera:Camera3D
var instance
var placing = false 
var range = 1000
var can_place = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_viewport().get_camera_3d()
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventKey and  event.is_pressed():
		match event.keycode:
			KEY_1:
				print(1)
				instance = tower.instantiate()
				placing = true
				get_parent().add_child(instance)
			KEY_2 when placing:
				print(2)
				instance.queue_free()
				placing = false
				get_parent().add_child(instance)
			KEY_SPACE when  can_place:
				placing = false
				can_place = false
				instance.placed()
				
			_:
				pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if placing:
		var mouse_pos = get_viewport().get_mouse_position()
		var ray_origin = camera.project_ray_origin(mouse_pos)
		var ray_end = ray_origin + camera.project_ray_normal(mouse_pos) * range
		var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
		var collision = camera.get_world_3d().direct_space_state.intersect_ray(query)
		if collision:
			instance.transform.origin = collision.position
			can_place = instance.check_placement()
	pass
