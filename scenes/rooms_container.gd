extends Node3D

@onready var room = preload("res://scenes/rooms/door_rooms/door_room_1.tscn")
@onready var rooms = get_children()

var doors = []


func _ready() -> void:
	pass


func generate_room():
	var new_room = room.instantiate()
	
