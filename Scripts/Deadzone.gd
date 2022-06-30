extends Area2D

signal hit


func _on_Deadzone_body_entered(body):
	if body.is_in_group('boxes'):
		emit_signal('hit')
		yield(get_tree().create_timer(10.0), "timeout")
		get_tree().reload_current_scene()
		
