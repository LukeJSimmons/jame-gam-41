extends Node3D

@onready var rooms = get_children()

var doors = []

var colors = []


func _ready() -> void:
	for room in rooms:
		doors += room.get_doors()
	
	for door in doors:
		colors.append(door.color)
	
	print(rooms)
	print(doors)
	print(colors)
