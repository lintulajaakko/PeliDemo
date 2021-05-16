extends Node


signal hp_changed(new_hp)
signal max_hp_changed(new_max_hp) 
signal depleted

export(int) var max_hp = 10 setget set_max
onready var current_hp = max_hp setget set_current

func _ready():
	_initialize()

func take_damage(amount):
	set_current(current_hp - amount)

func set_max(new_max_hp):
	max_hp = max(1, new_max_hp)
	emit_signal("max_hp_changed", max_hp)

func set_current(new_hp):
	current_hp = clamp(new_hp, 0, max_hp)
	emit_signal("hp_changed", current_hp)
	
	if current_hp == 0:
		emit_signal("depleted")

func _initialize():
	emit_signal("max_hp_changed", max_hp)
	emit_signal("hp_changed", current_hp)
