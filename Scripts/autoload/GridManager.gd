extends Node

@onready var tower = preload("res://Scenes/Towers/tower_1.tscn")

var camera: Camera3D
var instanca: Node
var placing: bool = false
var range = 1000

@onready var item_list = $ItemList

func _ready() -> void:
	camera = get_viewport().get_camera_3d()
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey and  event.pressed():
		match event.keycode:
			KEY_1:
				instanca = tower.instantiate()
			_:
				pass
	pass
	placing = true
	get_parent().add_child(instanca)

func _process(delta: float) -> void:
	if placing:
		var mous_pos:Vector2 = get_viewport().get_mouse_position()
		var ray_origin:Vector3 = camera.project_ray_origin(mous_pos)
		var ray_end:Vector3 = ray_origin + camera.project_ray_normal(mous_pos) + range
		var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
		
	pass
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
