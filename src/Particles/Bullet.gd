extends Area2D
 

var shot_speed = 750

func _physics_process(delta: float) -> void:
	position += transform.x * shot_speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("enemies"):
		body.queue_free()
	
	queue_free()
