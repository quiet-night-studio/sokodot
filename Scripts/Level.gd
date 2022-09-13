extends Node2D

var spot_counter = 0
var display_name: String

# When level loaded, display the level number based off of the name of the level filename.
func _ready():
	spot_counter = 0
	display_name = "Level " + str(int(filename)) # -> res://Scenes/Level_X.tscn
	for child in get_children():
		if child.is_in_group("spot"):
			spot_counter +=1
		
# Sends game script location of the Position2D node when called upon - used when resetting, changing, or leaving a level.
func start_position() -> Vector2:
	return $StartPosition.position
	
	
func spot_loss():
	spot_counter +=1
	print(spot_counter)
	
# If all spots are returning a value of 0, call the win function and tell it to result with the name of the next level.
func spot_manager():
	spot_counter -= 1
	print(spot_counter)
	yield(get_tree().create_timer(1.0), "timeout")
	if spot_counter == 0:
		var level_path = "res://Scenes/Level_" + str(int(filename) + 1) + ".tscn"
		get_parent().game_win(level_path)
		

func _on_Deadzone_dead(): # Consider changing the name of this function to something more understandable.
	get_parent().game_end()

func _unhandled_input(event):
	# Reset the game
	if event.is_action_pressed("reset"):
		get_parent().load_level(filename)
		
	if event.is_action_pressed("pause"):
		var level_path = "res://Scenes/Level_" + str(int(filename)) + ".tscn"
		get_parent().save_game(level_path)
