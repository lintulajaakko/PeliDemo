extends Control

onready var health_bar = $Bar
onready var under_bar = $UnderBar
onready var hp_update = $HpUpdate

func _on_Health_hp_changed(new_hp) -> void:
	health_bar.value = new_hp
	hp_update.interpolate_property(under_bar, "value", under_bar.value, new_hp, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	hp_update.start()


#	update_tween.interpolate_property(under_bar, "value", under_bar.value, new_hp, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
#	update_tween.start()


func _on_Health_max_hp_changed(new_max_hp) -> void:
	health_bar.max_value = new_max_hp
	under_bar.max_value = new_max_hp
