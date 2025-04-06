extends Node3D

@onready var nav = get_parent()
@onready var door_room = preload("res://scenes/rooms/door_room.tscn")
@onready var key_room = preload("res://scenes/rooms/key_room.tscn")
@onready var lock_room = preload("res://scenes/rooms/lock_room.tscn")
var rooms = get_children()

var doors = []

var colors = {}

var has_key_room = false
var has_lock_room = false

var room_id = 0


func _ready():
	doors = get_child(0).doors


func generate_room(enter_door):
	rooms = get_children()
	
	var new_room = determine_room_type()
	new_room.position = rooms[-1].global_position + Vector3(10,0,0)
	new_room.id = room_id
	room_id += 1
	self.add_child(new_room)
	
	nav.bake_navigation_mesh()
	return new_room

func determine_room_type():
	var rand_num = randi_range(0,10)
	match rand_num:
		0:
			if !has_key_room:
				has_key_room = true
				return key_room.instantiate()
		1:
			if !has_lock_room:
				has_lock_room = true
				return lock_room.instantiate()
	return door_room.instantiate()
