extends Node3D

var door = preload("res://scenes/door/door.tscn")

@onready var rooms_container = get_parent()
@onready var door_points = [$door_point1,$door_point2,$door_point3,$door_point4]
@onready var room_designs = [$room1,$room2,$room3,$room4,$room5]

@export var num_of_doors = randi_range(2,4)

var doors = []


func _ready():
	for n in num_of_doors:
		create_door(n)
	room_designs[randi_range(0,4)].visible = true
	$CSGCombiner3D.visible = false

func create_door(n):
	var new_door = door.instantiate()
	new_door.position = door_points[n].position
	new_door.rotation = door_points[n].rotation
	doors.append(new_door)
	rooms_container.doors.append(new_door)
	add_child(new_door)
	new_door.check_for_partner_door()
	print(rooms_container.doors)
