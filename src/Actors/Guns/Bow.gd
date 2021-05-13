extends Gun


func _ready() -> void:
	bullet_speed = 2500
	fire_rate = 0.01
	#bullet = preload("res://src/Actors/Bullets/BowArrow.tscn")
	gun_id = 2


func _on_Player_weapon_switched(type: int) -> void:
	if type != gun_id:
		can_fire = false
