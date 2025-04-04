extends Area3D

@onready var mesh = $MeshInstance3D
@onready var exit_position = $exit_position
@onready var room = get_parent()
@onready var rooms_container = room.get_parent()

@export var color := Color(0,0,0)

var exit_door = null


func _ready() -> void:
	mesh.set_surface_override_material(0, StandardMaterial3D.new())
	var new_color = mesh.get_surface_override_material(0)
	if color == Color(0,0,0):
		create_color()
	new_color.albedo_color = color

func _process(delta):
	$CollisionShape3D.disabled = !visible

func create_color():
	randomize()
	color = Color(randf_range(0,1), randf_range(0,1), randf_range(0,1))

func enter(player):
	if exit_door == null:
		var new_room = rooms_container.generate_room(self)
		exit_door = new_room.doors[0]
	player.position = exit_door.exit_position.global_position
	player.rotation.y = exit_door.exit_position.rotation.y
