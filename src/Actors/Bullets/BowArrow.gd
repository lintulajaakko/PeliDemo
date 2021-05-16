extends Bullet


func _ready() -> void:
#	add_to_group("arrows")
	damage = 5 

func getDamage():
	return damage 
