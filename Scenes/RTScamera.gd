extends Node3D

@onready var rotation_x = $CameraRotationX
@onready var zoom_pivot = $CameraRotationX/CameraZoomPivot
@onready var camera_3d: Camera3D = $CameraRotationX/CameraZoomPivot/Camera3D

@export var move_speed: float = 0.5
@export var lerp_coef_position: float = 0.1
@export var lerp_coef_rotation: float = 0.5
@export var lerp_coef_zoom: float = 0.05
@export var rotation_speed: float = 2
@export var rotation_target: float
@export var zoom_speed: float = 5
@export var zoom_target: float
@export var min_zoom: float = -20
@export var max_zoom: float = 20.0
@export var mouse_sens: float = 0.2


var move_target: Vector3

func _ready() -> void:
	move_target = position
	rotation_target = rotation_degrees.y
	zoom_target = camera_3d.position.z
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.is_action_pressed("rotate"):
		rotation_target -= event.relative.x * mouse_sens
		rotation_x.rotation_degrees.x -= event.relative.y * mouse_sens
		rotation_x.rotation_degrees.x = clamp(rotation_x.rotation_degrees.x, -10, 30)

func _process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	var vieport_size = get_viewport().get_visible_rect().size
	
	
	if Input.is_action_pressed("rotate"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_released("rotate"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	var scroll_direction = Vector3.ZERO
	
	var direction = Vector2.ZERO
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var move_direction = (transform.basis * Vector3(direction.x, 0, direction.y)).normalized()
	var rotate_keys = Input.get_axis("rotate_left", "rotate_right")
	
	var zoom_dir = (int(Input.is_action_just_released("mouse_wheel_up")) - 
					int(Input.is_action_just_released("mouse_wheel_down")))
	
	rotation_target += rotate_keys * rotation_speed
	move_target += move_speed * move_direction
	zoom_target += zoom_dir * zoom_speed
	
	position = lerp(position, move_target, lerp_coef_position)
	rotation_degrees.y = lerp(rotation_degrees.y, rotation_target, lerp_coef_rotation)
	camera_3d.position.z = lerp(camera_3d.position.z, zoom_target, lerp_coef_zoom)
