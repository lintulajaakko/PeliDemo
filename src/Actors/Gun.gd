extends Node2D
class_name Gun

export var bullet_speed = 0
export var fire_rate = 0.0
var arrows = preload("res://src/Actors/Bullets/BowArrow.tscn")
var rifle_rounds = preload("res://src/Actors/Bullets/RifleRound.tscn")
#var ammo_type
var bullet
var can_fire = true

var current_weapon
onready var wp_1 = $Rifle
onready var wp_2 = $Bow

func _unhandled_input(event: InputEvent) -> void:
	look_at(get_global_mouse_position())
	#var call = ray.get_collider()

#-------------------------------------------------------------------------------
	if event.is_action_pressed("shoot") and can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = global_position
		bullet_instance.rotation_degrees = rotation_degrees - 90
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true

