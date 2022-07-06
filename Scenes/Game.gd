extends Node2D

var moves: int = 0

func new_game():
	# Saved game file should be checked here.
	# If there is anything, load the correct level.
	# If not, load level 1.

	var next_level = load("res://Scenes/Level_1.tscn")
	var level = next_level.instance()
	add_child(level)

	# We have to hide every interface object not related to the level.
	$HUD.game_hud()
	$HUD.display_level(level.display_name)

	# Set the player position based on the level.
	player_position(level.start_position())

# Sets the player to the defined position.
func player_position(position):
	$Player.position = position

func show_level(level):
	$HUD/LevelLabel.text = level
	$HUD/LevelLabel.show()
#	$Inputs/Input.show()

func update_moves():
	moves += 1
	$HUD.update_moves(str(moves))
