extends Gun

onready var animation = $AnimationPlayer

func _ready() -> void:
	bullet_speed = 2500
	fire_rate = 1
	#bullet = preload("res://src/Actors/Bullets/BowArrow.tscn")
	gun_id = 2
	damage = 5
	animation.playback_speed = 3
	shoot_delay = 0.25

 
func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("shoot"):
		animation.play("Shoot_left")

func _on_Player_weapon_switched(type: int) -> void:
	if type != gun_id:
		can_fire = false
