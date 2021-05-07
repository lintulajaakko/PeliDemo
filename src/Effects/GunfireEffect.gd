extends Node2D

onready var pointer: = $Pointer
onready var gunfireEffect: = $Particles2D
export var gunfire: PackedScene

func _ready():
	gunfireEffect.emitting = true

func _on_Timer_timeout() -> void:
	queue_free()
