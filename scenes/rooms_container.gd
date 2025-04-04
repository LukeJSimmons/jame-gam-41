extends Node3D

@onready var room = preload("res://scenes/rooms/door_rooms/door_room_1.tscn")
@onready var rooms = get_children()

var doors = []


func _ready() -> void:
	pass


func generate_room(enter_door):
	var new_room = room.instantiate()
	new_room.position = position + Vector3(10,0,0)
	new_room.get_node('door').exit_door = enter_door
	self.add_child(new_room)
	return new_room
