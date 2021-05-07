extends Actor

onready var pointer: = $Pointer
onready var ray: = $Pointer/RayCast2D
export var gunfire: PackedScene
onready var gun_position: = $Pointer/gun
signal fired_shot
signal gun_firing




func _unhandled_input(event: InputEvent) -> void:
	var call = ray.get_collider()
	if event.is_action_pressed("shoot"):
		emit_signal("gun_firing", gun_position.position)
		if ray.is_colliding():
			emit_signal("fired_shot", ray.get_collision_point())
		#call.kill()
	


func rotate_pointer(point_direction: Vector2)->void:
	var temp = rad2deg(atan2(point_direction.y, point_direction.x))
	pointer.rotation_degrees = temp


func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction: = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	var aim_position = get_global_mouse_position() - global_position
	rotate_pointer(aim_position)



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

func generate_gunfire(fire_position: Vector2, fire_angle: float)->void:
	var temp = gunfire.instance()
	add_child(temp)
	temp.position = fire_position
	temp.set_rotation = fire_angle


func _on_Player_gun_firing(fire_position: Vector2) -> void:
	var gun_rotation = get_global_mouse_position() - global_position
	var temp_angle = atan2(gun_rotation.y, gun_rotation.x)
	fire_position = pointer.position
	generate_gunfire(fire_position, temp_angle)
	
