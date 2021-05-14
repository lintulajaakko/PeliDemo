extends Node2D
class_name Gun

export var bullet_speed = 0
export var fire_rate = 0.0

var bullet
var ammo_type 
var can_fire = false
var arrows = preload("res://src/Actors/Bullets/BowArrow.tscn")
var rifle_rounds = preload("res://src/Actors/Bullets/RifleRound.tscn")
var gun_id 
var damage




func _unhandled_input(event: InputEvent) -> void:
	look_at(get_global_mouse_position())
	#var call = ray.get_collider()
	if Input.is_action_pressed("no_weapon"):
		can_fire = false

	if Input.is_action_pressed("weapon_1"):
		ammo_type = rifle_rounds
		can_fire = true 
	
	if Input.is_action_pressed("weapon_2"):
		ammo_type = arrows
		can_fire = true
	
#-------------------------------------------------------------------------------
	if event.is_action_pressed("shoot") and can_fire:
		var bullet_instance = ammo_type.instance()
		bullet_instance.position = global_position
		bullet_instance.rotation_degrees = rotation_degrees - 90
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
