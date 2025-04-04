extends Node3D

@onready var rooms_container = get_parent()
@onready var doors = [$door, $door2, $door3, $door4]

@export var num_of_doors: int


func _ready():
	for n in num_of_doors:
		doors[n].visible = true
