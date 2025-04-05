extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D

const STARTING_SPEED = 2.0
const SPEED_MULTIPLIER = 1.0

var speed = STARTING_SPEED
var player = null

var targets = []

@export var player_path: NodePath


func _ready() -> void:
	player = get_node(player_path)

func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	if targets.is_empty():
		nav_agent.set_target_position(player.global_transform.origin)
	else:
		nav_agent.set_target_position(targets[0].global_transform.origin)
	
	var next_nav_point = nav_agent.get_next_path_position()
	
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	
	move_and_slide()


func increase_speed():
	speed += SPEED_MULTIPLIER


func _on_area_3d_area_entered(area):
	if area.is_in_group("door"):
		area.enter(self)
		targets.pop_front()
