extends Node3D

@onready var room = preload("res://scenes/rooms/door_rooms/door_room_1.tscn")
var rooms = get_children()

var doors = []


func _ready() -> void:
	pass


func generate_room(enter_door):
	rooms = get_children()
	
	var new_room = room.instantiate()
	new_room.position = rooms[-1].global_position + Vector3(10,0,0)
	new_room.num_of_doors = randi_range(2,4)
	new_room.get_node('door').exit_door = enter_door
	new_room.get_node('door').color = enter_door.color
	self.add_child(new_room)
	return new_room
