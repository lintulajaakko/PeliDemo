extends "res://src/Actors/Actor.gd"

#onready var raycast = $RayCast2D
onready var hitbox = $CollisionShape2D

var player = null

func _ready() -> void:
	set_physics_process(false)
	velocity.x = -speed.x
	add_to_group("enemies")
	health_points = 10
	enemy_health.set_max(health_points)
	health_bar._on_health_updated(health_points)
	health_bar._on_max_health_update(health_points)


onready var enemy_health = $Health
onready var health_bar = $HealthBar
onready var dmg_amount

func _on_HitDetector_body_entered(body: Node) -> void:
	if body.is_in_group("rifle_rounds"):
		dmg_amount = 1
	if body.is_in_group("arrows"):
		dmg_amount = 10
	enemy_health.take_damage(dmg_amount)
	health_bar._on_health_updated(enemy_health.current_hp)





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





