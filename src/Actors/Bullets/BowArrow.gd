extends Bullet


func _ready() -> void:
#	add_to_group("arrows")
	damage = 10 

func getDamage():
	return damage 
