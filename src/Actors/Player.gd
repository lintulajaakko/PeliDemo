extends Actor

onready var player_animation = $AnimationPlayer

func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction: = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	
	if Input.get_action_strength("move_right") and !Input.get_action_strength("jump"):
		player_animation.play("Walk_Right")
	if Input.is_action_just_released("move_right"):
		player_animation.stop()
	
	if Input.get_action_strength("move_left") and !Input.get_action_strength("jump"):
		player_animation.play("Walk_Left")
	if Input.is_action_just_released("move_left"):
		player_animation.stop()
	
	if Input.get_action_strength("jump") and (direction.x == 1 or direction.x == 0):
		player_animation.play("Jump_Right")
	
	if Input.get_action_strength("jump") and (direction.x == -1 or direction.x == 0):
		player_animation.play("Jump_Left")


func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)



func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
#	if is_jump_interrupted: 
#		new_velocity.y = 0.0
	return new_velocity
