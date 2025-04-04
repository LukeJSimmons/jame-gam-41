extends Node3D

@onready var rooms_container = get_parent()

func get_doors():
	var doors = []
	for child in get_children():
		if child.is_in_group("door"):
			doors.append(child)
	return doors
