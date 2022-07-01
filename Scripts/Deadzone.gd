extends Area2D

signal hit


func _on_Deadzone_body_entered(body):
	if body.is_in_group('boxes'):
		emit_signal('hit')
		
