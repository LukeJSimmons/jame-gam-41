extends Area3D

@onready var mesh = $door/door
@onready var exit_position = $exit_position
@onready var room = get_parent()
@onready var rooms_container = room.get_parent()

var color
var hex_color

var exit_door


func _ready() -> void:
	mesh.set_surface_override_material(0, StandardMaterial3D.new())
	var new_color = mesh.get_surface_override_material(0)
	if hex_color == null:
		create_color()

func _process(delta):
	var new_color = mesh.get_surface_override_material(0)
	new_color.albedo_color = color

func create_color():
	randomize()
	var new_color = Global.doors.pop_at(randi_range(0,Global.doors.size()-1))
	
	if new_color == null:

		queue_free()
		return
	
	hex_color = new_color
	color = Color.hex(new_color)

func enter(player):
	if exit_door == null:
		var new_room = rooms_container.generate_room(self)
		
		exit_door = new_room.doors[0]
		
		for door in new_room.doors:
			if door.hex_color == hex_color:
				exit_door = door
		
		exit_door.exit_door = self
		exit_door.hex_color = Global.doors.pop_at(Global.doors.find(hex_color))
		exit_door.color = Color.hex(hex_color)
	player.position = exit_door.exit_position.global_position
	player.rotation.y += (exit_door.exit_position.global_rotation.y - global_rotation.y)

func check_for_partner_door():
	for door in rooms_container.doors:
		if door.hex_color == hex_color && door.name != name:
			exit_door = door
			door.exit_door = self
			print('has partner')
	print(rooms_container.doors)
