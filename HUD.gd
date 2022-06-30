extends CanvasLayer

func show_game_over_win():
	$WinLabel.text = "You won!"
	$WinLabel.show()
	yield(get_tree().create_timer(2.0), "timeout")
	$CountdownLabel.text = "Switching levels in 5..."
	$WinLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$CountdownLabel.text = "Switching levels in 4..."
	$WinLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$CountdownLabel.text = "Switching levels in 3..."
	$WinLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$CountdownLabel.text = "Switching levels in 2..."
	$WinLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$CountdownLabel.text = "Switching levels in 1..."
	$WinLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene("res://Scenes/Level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")
	
	
	
	
func show_game_over_lose():
	$LoseLabel.text = "Press R to Reset"
	$LoseLabel.show()
	yield(get_tree().create_timer(5.0), "timeout")
	$CountdownLabel.text = "Restarting in 5..."
	$CountdownLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$CountdownLabel.text = "Restarting in 4..."
	$CountdownLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$CountdownLabel.text = "Restarting in 3..."
	$CountdownLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$CountdownLabel.text = "Restarting in 2..."
	$CountdownLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$CountdownLabel.text = "Restarting in 1..."
	$CountdownLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$CountdownLabel.hide()
	
	# There must be a better system to do this, possibly using a timer, but it is 12pm.
