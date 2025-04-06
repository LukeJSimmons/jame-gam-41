extends Node3D
var door = preload("res://scenes/door/door.tscn")
@onready var rooms_container = get_parent()
@onready var door_points = [$door_point1,$door_point2,$door_point3,$door_point4]
@onready var room_designs = [$room1,$room2,$room3,$room4,$room5]
@export var type = 'door'
@export var num_of_doors = randi_range(2,4)
var doors = []
var decoration_paths = [
	"res://scenes/decorations/decor1.tscn",
	"res://scenes/decorations/decor2.tscn",
	"res://scenes/decorations/decor3.tscn",
	"res://scenes/decorations/decor4.tscn",
	"res://scenes/decorations/decor5.tscn",
	"res://scenes/decorations/decor6.tscn",
	"res://scenes/decorations/decor7.tscn"
] # Add all your decoration scenes here

func _ready():
	# Setup room based on type
	if type == 'door':
		build_door_room()
	elif type == 'key':
		build_key_room()
	elif type == 'lock':
		build_lock_room()
	
	# Select a random room design
	room_designs[randi_range(0,4)].visible = true
	$CSGCombiner3D.visible = false
	
	# Add decorations (only once)
	build_decorations()

func build_decorations():
	var num_decorations = randi_range(3, 8)  # You can tweak these values
	
	for i in num_decorations:
		var path = decoration_paths[randi_range(0, decoration_paths.size() - 1)]
		var decor_scene = load(path)
		if decor_scene:
			var decor = decor_scene.instantiate()
			
			# Set position using Vector3 constructor
			var x = randf_range(-1.5, 1.5)  # Adjust these values to match your room size
			var y = 0  # Floor level
			var z = randf_range(-1.5, 1.5)  # Adjust these values to match your room size
			
			# Add the decoration as a child first
			add_child(decor)
			
			# Then set its position and rotation
			if decor is Node3D:  # Check if it's a Node3D type
				decor.position = Vector3(x, y, z) + position
				decor.rotation_degrees = Vector3(0, randf_range(0, 360), 0)
			
func build_door_room():
	create_doors()

func build_key_room():
	num_of_doors = 2
	create_doors()

func build_lock_room():
	num_of_doors = 3
	create_doors()
	doors[1].is_locked = true

func create_doors():
	for n in num_of_doors:
		create_door(n)

func create_door(n):
	var new_door = door.instantiate()
	
	# Add the door as a child first
	add_child(new_door)
	
	# Then copy position and rotation from door_points
	if door_points[n] is Node3D and new_door is Node3D:
		new_door.position = door_points[n].position
		new_door.rotation = door_points[n].rotation
	
	doors.append(new_door)
	rooms_container.doors.append(new_door)
	
	new_door.check_for_partner_door()
	print(rooms_container.doors)
