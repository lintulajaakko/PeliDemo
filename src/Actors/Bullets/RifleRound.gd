extends Bullet

func _ready() -> void:
#	add_to_group("rifle_rounds")
	damage = 2

func getDamage():
	return damage
