extends Node2D

var spot_counter = 1
var display_name: String

signal game_end

func _ready():
	display_name = "Level " + str(int(filename))

func start_position() -> Vector2:
	return $StartPosition.position
	
#func _ready():
#	get_parent().show_level("Level 1")
#	$HUD/LevelLabel.text = "Level 1"
#	$HUD/LevelLabel.show()
#	$Inputs/Input.show()
	
#func _process(delta):
#	$HUD/MoveLabel.text = "Moves: " + str(moves)

func spot_manager():
	spot_counter -= 1
	if spot_counter == 0:
		var level_path = "res://Scenes/Level_" + str(int(filename) + 1) + ".tscn"
		get_parent().game_win(level_path)
		
		
#func _on_Spot_hit():
#	spot_counter -= 1
#	$HUD.show_game_over_win()
#	yield(get_tree().create_timer(5.0), "timeout")
#	get_tree().change_scene("res://Scenes/Level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")
#
#func _on_Deadzone_hit():
	#get_parent().game_end()



func _on_Deadzone_dead():
	get_parent().game_end()
