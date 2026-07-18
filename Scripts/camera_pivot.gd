extends Node3D

@export var cameraSens: float = 0.004
@export var cameraSpeed: float = 2
@export var zoomInc: int = 2
@export var maxZoom: int = 40
@export var minZoom: int = 10

@onready var camera_3d: Camera3D = $Camera3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"): get_tree().quit()
	
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * cameraSens
	
	_camera_zoom()
		
func _physics_process(delta: float) -> void:
	_camera_movement()
	
func _camera_movement():
	var direction = Vector2.ZERO
	direction.y = Input.get_axis("ui_up", "ui_down")
	direction.x = Input.get_axis("ui_left", "ui_right")
	
	global_position += (global_basis * Vector3(direction.x, 0, direction.y)).normalized() * cameraSpeed
	
	#print(global_position)

func _camera_zoom():
	var zoomChange: int = 0
	if Input.is_action_pressed("mouse_wheel_up"):
		zoomChange -= zoomInc
	elif Input.is_action_pressed("mouse_wheel_down"):
		zoomChange += zoomInc
	
	camera_3d.size += zoomChange
	camera_3d.size = clamp(camera_3d.size, minZoom, maxZoom) 
		
