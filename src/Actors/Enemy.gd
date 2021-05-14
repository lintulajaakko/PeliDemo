extends "res://src/Actors/Actor.gd"

#onready var raycast = $RayCast2D
onready var hitbox = $CollisionShape2D
onready var enemy_health = $Health

var player = null

func _ready() -> void:
	set_physics_process(false)
	velocity.x = -speed.x
	add_to_group("enemies")
	health_points = 10

func hp_events() -> void:
	enemy_health.set_max(health_points)




func _on_HitDetector_body_entered(body: Node) -> void:
	var temp_hp = enemy_health.current_hp
	if body.is_in_group("bullets") and temp_hp>0:
		temp_hp -= 2
	enemy_health.set_current(temp_hp)
	print(temp_hp)





func _physics_process(delta: float) -> void:

#	if raycast.is_colliding():
#		var call = raycast.get_collider()
#		if call.name == "Player":
#			call.kill()
	
	
	
	velocity.y += gravity * delta
	if is_on_wall():
		velocity.x *= -1.0
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y



func set_player(p):
	player = p


