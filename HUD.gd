extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	$ButtonControl/Menu/Play.grab_focus()

func update_moves(number):
	$MoveCounter.text = number

func display_level(level):
	$LevelLabel.text = level

# ==================================================================================================

func game_hud():
	$WinLabel.hide()
	$LoseLabel.hide()
	$CountdownLabel.hide()
	$VideoPlayer.hide()
	$ButtonControl.hide()
	$Sokodot.hide()

# Button controls
func _on_Play_pressed():
	emit_signal("start_game")

func _on_Quit_pressed():
	get_tree().quit()

func _on_Levels_pressed():
	get_tree().change_scene("res://Scenes/Level_select.tscn")

# ==================================================================================================

func show_game_over_win():
	$WinLabel.text = "You won!"
	$WinLabel.show()
	yield(get_tree().create_timer(2.0), "timeout")
	$CountdownLabel.text = "Switching levels in 3..."
	$CountdownLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$CountdownLabel.text = "Switching levels in 2..."
	yield(get_tree().create_timer(1.0), "timeout")
	$CountdownLabel.text = "Switching levels in 1..."
	yield(get_tree().create_timer(1.0), "timeout")
	#get_tree().change_scene("res://Scenes/Level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")

func show_game_over_lose():
	$WinLabel.hide()
	$LoseLabel.text = "Press R to Reset"
	$LoseLabel.show()
	yield(get_tree().create_timer(2.0), "timeout")
	$CountdownLabel.text = "Restarting in 3..."
	$CountdownLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$CountdownLabel.text = "Restarting in 2..."
	yield(get_tree().create_timer(1.0), "timeout")
	$CountdownLabel.text = "Restarting in 1..."
	yield(get_tree().create_timer(1.0), "timeout")
	$CountdownLabel.hide()
	
	# There must be a better system to do this, possibly using a timer, but it is 12pm.
