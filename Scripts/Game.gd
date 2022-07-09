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
	
func change_level(name):
	remove_child(find_node('Level', true, false))
	print(find_node('level'), true, false)
	print('Notice how it returns Object Null, Im not exactly sure how the game is actually changing to the next scene without having problems.')
	var next_level = load("res://Scenes/" + name + ".tscn")
	var level = next_level.instance()
	add_child(level)
	player_position(level.start_position())
	$HUD.display_level(level.display_name)
	$HUD.game_hud()
	
func reset_level(name):
	get_tree().reload_current_scene()
	# Instead of reloading current scene because it reloads Game and breaks, I'd like to remove the level child/node like we do on line 33, but it doesn't find our level.
	
	
func game_end():
	$HUD.show_game_over_lose()
	yield(get_tree().create_timer(5.0), "timeout") # This timeout is needed to give line 43 enough time to execute it's actions.
	reset_level(name)
	#get_tree().reload_current_scene()
	
