extends Area2D

signal hit

func _on_Spot_body_entered(body):
	if body.is_in_group('boxes'):
		emit_signal('hit')



func _on_Spot_hit():
	get_parent().spot_manager()
	#pass # Replace with function body.
