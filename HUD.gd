extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	$PauseControl.hide()
	$LevelControl.hide()
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
	$VideoPlayer.hide()
	$ButtonControl.hide()
	$Sokodot.hide()
	$LevelControl.hide()
	$PauseControl.hide()
	

# Main Menu
func _on_Play_pressed():
	$MoveCounter.show()
	$MoveLabel.show()
	$LevelLabel.show()
	$ResetLabel.show()
	emit_signal("start_game")

func _on_Quit_pressed():
	get_tree().quit()

# BUG: Caused by the level selection bug I think
func _on_Levels_pressed():
	$ButtonControl.hide()
	$LevelControl.show()
# ==============================

# Level Selection Menu
# BUG: If we use the set_level function, selecting a level in the pause menu of a current level does not remove the past child.
#	   If we use the load_level function, it cannot find the next level.
func _on_Level1_Button_pressed():
	get_parent().load_level("Level_1")
	$MoveCounter.show()
	$MoveLabel.show()
	$LevelLabel.show()
	$ResetLabel.show()
	
func _on_Level2_Button_pressed():
	get_parent().load_level("Level_2")
	$MoveCounter.show()
	$MoveLabel.show()
	$LevelLabel.show()
	$ResetLabel.show()
	
func _on_Level3_Button_pressed():
	get_parent().load_level("Level_3")
	$MoveCounter.show()
	$MoveLabel.show()
	$LevelLabel.show()
	$ResetLabel.show()

func _on_Return_Button_pressed():
	$ButtonControl.show()
	$LevelControl.hide()

# ==============================

# Pause Menu
func pause():
	game_hud()
	$MoveCounter.hide()
	$MoveLabel.hide()
	$LevelLabel.hide() # -> I would make these into a function called hide_hud but we have a function named game_hud,
	$ResetLabel.hide() # I cannot think of a better name though
	$PauseControl.show()
	$PauseControl/Menu_Buttons/resume_button.grab_focus()
	
func _on_resume_button_pressed():
	get_parent().game_unpause() # I think there is a better way to organize this
	$PauseControl.hide()
	$MoveCounter.show()
	$MoveLabel.show()
	$LevelLabel.show()
	$ResetLabel.show()
	
func _on_levels_button_pressed():
	print('The button was pressed')
	$PauseControl.hide()
	$LevelControl.show()
	$LevelControl/Menu_Buttons/Level1_Button.grab_focus()
	
func _on_menu_button_pressed():
	$ButtonControl/Menu/Play.grab_focus()
	$VideoPlayer.show()
	$VideoPlayer.paused = false # I *think* this line fixes the videoplayer freezing when transitioning menus
	$Sokodot.show()
	$PauseControl.hide()
	$ButtonControl.show()
	
# ==============================

# Win & lose HUD control
func show_game_over_win():
	$WinLabel.text = "You won!"
	$WinLabel.show()

func show_game_over_lose():
	$WinLabel.hide()
	$LoseLabel.text = "Try again!"
	$LoseLabel.show()
