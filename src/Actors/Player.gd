extends Actor

onready var player_animation = $AnimationPlayer
onready var player_hp = $Health
onready var player_hp_bar = $HealthBar
onready var hit_timer = $HitTimer
onready var player_dmg_amount = 10
onready var timer_time

func _ready() -> void:
	health_points = 100
	timer_time = 1.2
	player_hp.set_max(health_points)
	player_hp.set_current(health_points)
	player_hp_bar._on_Health_max_hp_changed(health_points)
	player_hp_bar._on_Health_hp_changed(health_points)
	hit_timer.set_wait_time(timer_time)
	player_hp_bar.hide()

func _on_HitDetector_body_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		player_dmg_amount = 10
		player_hp.take_damage(player_dmg_amount)
		hit_timer.start()
		player_hp_bar.show()
	print(hit_timer.time_left)


func _on_HitTimer_timeout():
	player_hp_bar.hide()


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
		
	gun_inputs()
	#---------------------------------------------------------------------------

onready var wp_1 = $Rifle
onready var wp_2 = $Bow
var current_weapon = 0
signal weapon_switched


func gun_inputs() -> void:
	
	if Input.is_action_pressed("no_weapon"):
		current_weapon = 0
	
	if Input.is_action_pressed("weapon_1"):
		current_weapon = 1
	
	if Input.is_action_pressed("weapon_2"):
		current_weapon = 2
	
	if current_weapon == 0:
		wp_1.set_visible(false)
		wp_1.set_process(false)
		wp_2.set_visible(false)
		wp_2.set_process(false)
	
	if current_weapon == 1:
		wp_1.set_visible(true)
		wp_2.set_visible(false)
		wp_2.set_process(false)
		emit_signal("weapon_switched", current_weapon)


	if current_weapon == 2:
		wp_2.set_visible(true)
		wp_1.set_visible(false)
		wp_1.set_process(false)
		emit_signal("weapon_switched", current_weapon)

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






#func _unhandled_input(event: InputEvent) -> void:
#	look_at(get_global_mouse_position())
#	#var call = ray.get_collider()


