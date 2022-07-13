extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	$ButtonControl/Menu/Play.grab_focus()

func update_moves(number):
	$MoveCounter.text = number

func display_level(level):
	$LevelLabel.text = level

# ==============================
# Hides the overlay when called upon - used when resetting, changing, or leaving a level.
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
# ==============================
	
# Win & lose overlay
func show_game_over_win():
	$WinLabel.text = "You won!"
	$WinLabel.show()

func show_game_over_lose():
	$WinLabel.hide()
	$LoseLabel.text = "Try again!"
	$LoseLabel.show()
