extends Node2D

var moves: int = 0

func new_game():
	# Saved game file should be checked here.
	# If there is anything, load the correct level.
	# If not, load level 1.
	change_level("Level_1")

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

func change_level(name):
	remove_child(find_node('Level_?', true, false))
	var next_level = load("res://Scenes/" + name + ".tscn")
	var level = next_level.instance()
	add_child(level)
	player_position(level.start_position())
	$HUD.display_level(level.display_name)
	$HUD.game_hud()
	
func game_end():
	$HUD.show_game_over_lose()
	get_tree().reload_current_scene()
	
