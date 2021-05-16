extends Control

onready var health_bar = $Bar

func _on_health_updated(health):
	health_bar.value = health

func _on_max_health_update(max_health):
	health_bar.max_value = max_health
