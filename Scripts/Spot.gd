extends Area2D

signal hit
signal nothit

func _on_Spot_body_entered(body):
	if body.is_in_group('boxes'):
		emit_signal('hit')

func _on_Spot_body_exited(body):
	if body.is_in_group('boxes'):
		emit_signal('nothit')
		
func _on_Spot_nothit():
	print("Box exited Spot")
	get_parent().spot_loss()

func _on_Spot_hit():
	print("Box entered Spot")
	get_parent().spot_manager()
	#pass # Replace with function body.
