extends Node2D

var moves: int = 0


func new_game():
	# Saved game file should be checked here.
	# If there is anything, load the correct level.
	# If not, load level 1.
	set_level("Level_1")

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

func set_level(name):
	var load_level = load("res://Scenes/" + name + ".tscn")
	var level = load_level.instance()
	add_child(level)
	player_position(level.start_position())
	$HUD.display_level(level.display_name)
	$HUD.game_hud()
	
func change_level(filename):
	remove_child(find_node('Level', true, false))
	var next_level = load(filename)
	var level = next_level.instance()
	add_child(level)
	player_position(level.start_position())
	$HUD.display_level(level.display_name)
	$HUD.game_hud()
	$Player.should_move = true
	
func game_win(level_path):
	$Player.should_move = false
	$HUD.show_game_over_win()
	yield(get_tree().create_timer(1.0), "timeout") # This timeout is needed
	var file = File.new()
	if file.file_exists(level_path):
		change_level(level_path)
	else:
		print('The next level does not exist.')
	
func game_end():
	$Player.should_move = false
	$HUD.show_game_over_lose()
	yield(get_tree().create_timer(1.0), "timeout") # This timeout is needed to give line 43 enough time to execute it's actions.
	var node  = find_node('Level', true, false)
	change_level(node.filename)
	
	
	
	
