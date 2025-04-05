extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var player = get_parent().get_node("player")

const STARTING_SPEED = 2.0
const SPEED_MULTIPLIER = 0.1

var speed = STARTING_SPEED

var targets = []


func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	if targets.is_empty():
		nav_agent.set_target_position(player.global_transform.origin)
		look_at(player.position)
	else:
		nav_agent.set_target_position(targets[0].global_transform.origin)
		look_at(targets[0].position)
	
	var next_nav_point = nav_agent.get_next_path_position()
	
	velocity = (next_nav_point - global_transform.origin).normalized() * speed
	
	move_and_slide()


func increase_speed():
	speed += SPEED_MULTIPLIER


func _on_area_3d_area_entered(area):
	if area.is_in_group("door"):
		area.enter(self)
		targets.pop_front()


func _on_detection_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		targets = []
