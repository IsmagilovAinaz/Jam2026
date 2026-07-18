extends Node3D

@onready var raycasts:Array[RayCast3D] = [
	$"tower-base/Ray_1", $"tower-base/Ray_2", $"tower-base/Ray_3", $"tower-base/Ray_4"
]
@export var meshes: Array[MeshInstance3D]
@onready var area = $"tower-base/Area3D"
@onready var green_mat = preload("res://Scenes/Towers/new_standard_material_3d_1.tres")
@onready var red_mat = preload("res://Scenes/Towers/new_standard_material_3d.tres")


func check_placement() -> bool:
	for ray in raycasts:
		if !ray.is_colliding():
			placement_red()
			return false
	if area.get_overlapping_areas():
		placement_red()
		return false
	placement_green()
	return true

func placed() -> void:
	for mesh in meshes:
		mesh.material_override = null
	for ray in raycasts:
		ray.queue_free()
	pass

func placement_green() -> void:
	for mesh in meshes:
		mesh.material_override = green_mat

func placement_red() -> void:
	for mesh in meshes:
		mesh.material_override = red_mat
