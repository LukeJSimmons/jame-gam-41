extends Area3D

@onready var mesh = $MeshInstance3D
@onready var room = get_parent()

var color: Color


func _ready() -> void:
	randomize()
	var new_color = mesh.get_surface_override_material(0)
	new_color.albedo_color = Color(randf_range(0,1), randf_range(0,1), randf_range(0,1))
	color = new_color.albedo_color
