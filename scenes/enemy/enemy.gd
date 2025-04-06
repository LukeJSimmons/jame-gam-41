extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var player = get_parent().get_node("player")

const STARTING_SPEED = 2.0
const SPEED_MULTIPLIER = 0.1

var speed = STARTING_SPEED

var targets = []

var current_room_id


func _ready() -> void:
	$CollisionShape3D.disabled = true
	visible = false
	set_process(false)

func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	if current_room_id == player.current_room_id:
		targets = []
	
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


func _on_timer_timeout() -> void:
	$CollisionShape3D.disabled = false
	visible = true
	$AudioStreamPlayer3D.play()
	set_process(true)
