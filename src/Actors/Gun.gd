extends Node2D



onready var ray: = $RayCast2D

export var bullet_speed = 1000
export var fire_rate = 0.2
var bullet = preload("res://src/Effects/Bullet.tscn")
var can_fire = true 


func _unhandled_input(event: InputEvent) -> void:
	look_at(get_global_mouse_position())
	var call = ray.get_collider()
	if event.is_action_pressed("shoot") and can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = global_position
		bullet_instance.rotation_degrees = rotation_degrees - 90
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
#		if ray.is_colliding():
#			emit_signal("fired_shot", ray.get_collision_point())
