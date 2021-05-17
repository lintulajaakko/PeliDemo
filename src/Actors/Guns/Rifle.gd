extends Gun

func _ready() -> void:
	bullet_speed = 2000
	fire_rate = 0.1
	#bullet = preload("res://src/Actors/Bullets/RifleRound.tscn")
	gun_id = 1
	damage = 2
	shoot_delay = 0.0


func _on_Player_weapon_switched(type: int) -> void:
	if type != gun_id:
		can_fire = false
