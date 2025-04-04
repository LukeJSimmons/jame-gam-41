extends CharacterBody3D

@onready var head: Node3D = $Head
 
const JUMP_VELOCITY = 4.5

var speed = 5.0

const WALK_SPEED = 5.0
const RUN_SPEED = 8.0

const mouse_sens = 0.2

var lerp_speed = 10.0

var direction = Vector3.ZERO


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("run"):
		speed = RUN_SPEED
	else:
		speed = WALK_SPEED
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	direction = lerp(direction,(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(),delta*lerp_speed)
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()


func game_over():
	print("AHSBDJABSJHD")


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("enemy"):
		game_over()


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("door"):
		area.enter(self)
