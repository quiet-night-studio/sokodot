extends Node2D

var moves: int = 0

func new_game():
	$HUD.playing = true

	if(DataManager.save_exists()):
		DataManager.load_savegame()
		load_level(DataManager.level_name)
	else:
		set_level("Level_1")

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
	$HUD.ingame = true
	player_position(level.start_position())
	$HUD.display_level(level.display_name)
	$HUD.game_hud()
	$Player.should_move = true
	
func load_level(filename):
# If there is a level child attached to the game scene, remove it before continuing.
	var current_level_node = find_node('Level', true, false)
	if(current_level_node):
		remove_child(current_level_node)
		
# 	If the level does not exist, load the next level that does exist.
	if !ResourceLoader.exists(filename):
		filename = "res://Scenes/Level_" + str(int(filename) -1 ) + ".tscn"
		print('This level does not exist. Reverting to last existing level.') 
		# This DOES NOT work if the level is 7 and the next available is 5. 
		# That shouldn't be a problem though, as it shouldn't be possible to become two non-exising levels ahead.
		
#	Load the next level	and apply HUD + player information.
	var next_level = load(filename)
	var level = next_level.instance()
	add_child(level)
	$HUD.ingame = true
	player_position(level.start_position())
	$HUD.display_level(level.display_name)
	$HUD.game_hud()
	$HUD.playing = true
	$Player.should_move = true
	moves = 0
	$HUD.update_moves(str(moves))
	
func game_win(level_path):
	DataManager.level_name = level_path
	DataManager.write_savegame()

	$Player.should_move = false
	$HUD.show_game_over_win()
	yield(get_tree().create_timer(2.0), "timeout") # This timeout is needed to allow HUD to execute its code
	var file = File.new()
	if file.file_exists(level_path):
		load_level(level_path)
	else:
		$HUD.game_hud()
		$HUD.show_last_win()
		print('The next level does not exist.')

func game_end():
	$Player.should_move = false
	$HUD.show_game_over_lose()
	yield(get_tree().create_timer(2.0), "timeout") # This timeout is needed to give HUD enough time to execute its code
	var node  = find_node('Level', true, false)
	load_level(node.filename)

func game_pause():
	$HUD.playing = false
	$Player.should_move = false
	$HUD.pause()

func game_unpause():
	$Player.should_move = true

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		if($HUD.playing):
			game_pause()
		else:
			$HUD._on_resume_button_pressed()
			
func save_game(level_path):
	DataManager.level_name = level_path
	DataManager.write_savegame()
