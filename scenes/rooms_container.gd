extends Node3D

@onready var nav = get_parent()
@onready var room = preload("res://scenes/rooms/door_rooms/door_room_1.tscn")
var rooms = get_children()

var doors = []

var colors = {}


func _ready():
	doors = get_child(0).doors


func generate_room(enter_door):
	rooms = get_children()
	
	var new_room = room.instantiate()
	new_room.position = rooms[-1].global_position + Vector3(10,0,0)
	self.add_child(new_room)
	
	nav.bake_navigation_mesh()
	return new_room
