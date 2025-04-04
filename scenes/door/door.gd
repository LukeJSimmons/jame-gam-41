extends Area3D

@onready var mesh = $MeshInstance3D
@onready var exit_position = $exit_position
@onready var room = get_parent()

@export var color: Color
@export var exit_door_path: NodePath

var exit_door = null


func _ready() -> void:
	exit_door = get_node(exit_door_path)
	var new_color = mesh.get_surface_override_material(0)
	if !color:
		create_color()
	new_color.albedo_color = color

func create_color():
	randomize()
	color = Color(randf_range(0,1), randf_range(0,1), randf_range(0,1))

func enter(player):
	player.position = exit_door.exit_position.global_position
	player.rotation.y = exit_door.exit_position.rotation.y
