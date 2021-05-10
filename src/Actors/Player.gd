extends Actor

onready var player_animation = $AnimationPlayer




func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	var direction: = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	
	#---------------------------------------------------------------------------
	#Movement inputs
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
	
	#---------------------------------------------------------------------------
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

#-------------------------------------------------------------------------------
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
	
#---------------------------------------------------------------------------

var arrows = preload("res://src/Actors/Bullets/BowArrow.tscn")
var rifle_rounds = preload("res://src/Actors/Bullets/RifleRound.tscn")
var ammo_type
var can_fire = true
var bulletspeed
var firerate
var current_weapon
onready var wp_1 = $Rifle
onready var wp_2 = $Bow

func _unhandled_input(event: InputEvent) -> void:
	look_at(get_global_mouse_position())
	#var call = ray.get_collider()
	
	#Gun inputs
	#var current_weapon = 1
	if Input.is_action_pressed("weapon_1"):
		current_weapon = wp_1
		wp_1.set_visible(true)
		wp_2.set_visible(false)

	if Input.is_action_pressed("weapon_2"):
		current_weapon = wp_2
		wp_2.set_visible(true)
		wp_1.set_visible(false)
	
#	if current_weapon == 1:
#		get_node("Rifle").set_visible(true)
#		get_node("Bow").set_visible(false)
#	if current_weapon == 2:
#		get_node("Bow").set_visible(true)
#		get_node("Rifle").set_visible(false)
	firerate = wp_1.fire_rate
	bulletspeed = wp_1.bullet_speed
#-------------------------------------------------------------------------------
	if event.is_action_pressed("shoot") and can_fire:
		var bullet_instance = ammo_type.instance()
		bullet_instance.position = global_position
		bullet_instance.rotation_degrees = rotation_degrees - 90
		bullet_instance.apply_impulse(Vector2(), Vector2(bulletspeed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(firerate), "timeout")
		can_fire = true


