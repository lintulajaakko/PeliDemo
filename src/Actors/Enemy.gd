extends "res://src/Actors/Actor.gd"

onready var raycast = $RayCast2D
onready var hitbox = $CollisionShape2D

var player = null

func _ready() -> void:
	set_physics_process(false)
	velocity.x = -speed.x
	add_to_group("enemies")


func _physics_process(delta: float) -> void:

#	if raycast.is_colliding():
#		var call = raycast.get_collider()
#		if call.name == "Player":
#			call.kill()
	
	
	
	velocity.y += gravity * delta
	if is_on_wall():
		velocity.x *= -1.0
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y

func kill():
	queue_free()

func set_player(p):
	player = p
