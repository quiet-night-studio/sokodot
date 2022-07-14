extends Node2D

var moves: int = 0


func new_game():
	# Saved game file should be checked here.
	# If there is anything, load the correct level.
	# If not, load level 1.
	set_level("Level_1")
	
func _ready():
	print(name)

# Sets the player to the defined position.
func player_position(position):
	$Player.position = position

func show_level(level):
	$HUD/LevelLabel.text = level
	$HUD/LevelLabel.show()

func update_moves():
	moves += 1
	$HUD.update_moves(str(moves))

func set_level(level_name):
	var load_level = load("res://Scenes/" + level_name + ".tscn")
	var level = load_level.instance()
	add_child(level)
	player_position(level.start_position())
	$HUD.display_level(level.display_name)
	$HUD.game_hud()
	$Player.should_move = true
	
func load_level(filename):
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
	yield(get_tree().create_timer(2.0), "timeout") # This timeout is needed to allow HUD to execute its code
	var file = File.new()
	if file.file_exists(level_path):
		load_level(level_path)
	else:
		print('The next level does not exist.')
	
func game_end():
	$Player.should_move = false
	$HUD.show_game_over_lose()
	yield(get_tree().create_timer(2.0), "timeout") # This timeout is needed to give HUD enough time to execute its code
	var node  = find_node('Level', true, false)
	load_level(node.filename)

func game_pause():
	$Player.should_move = false
	$HUD.pause()
	
func game_unpause():
	$Player.should_move = true
