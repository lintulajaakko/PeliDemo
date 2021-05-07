extends Node2D

onready var hitEffect: = $Particles2D


func _ready():
	hitEffect.emitting = true





func _on_Timer_timeout():
	queue_free()
