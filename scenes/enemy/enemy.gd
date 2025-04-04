extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D

const STARTING_SPEED = 2.0
const SPEED_MULTIPLIER = 1.0

var speed = STARTING_SPEED
var player = null

@export var player_path: NodePath


func _ready() -> void:
	player = get_node(player_path)

func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	nav_agent.set_target_position(player.global_transform.origin)
	
	var next_nav_point = nav_agent.get_next_path_position()
	
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	
	move_and_slide()


func increase_speed():
	speed += SPEED_MULTIPLIER
