extends Node2D

var spot_counter = 1
var moves = 0


func _ready():
	$HUD/LevelLabel.text = "Level 2"
	$HUD/LevelLabel.show()
	
func _process(delta):
	$HUD/MoveLabel.text = "Moves: " + str(moves)


func _on_Spot_hit():
	spot_counter -= 1
	$HUD.show_game_over_win()
	#Delete line 19
	print("Level 3 will not load because it does not exist yet.")
	

func _on_Deadzone_hit():
	$HUD.show_game_over_lose()
		
	
