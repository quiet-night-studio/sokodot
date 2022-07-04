extends Node2D

var spot_counter = 1
var moves = 0

func _ready():
	$HUD/LevelLabel.text = "Level 2"
	$HUD/LevelLabel.show()
	$Inputs/Input.show()
	
func _process(delta):
	$HUD/MoveLabel.text = "Moves: " + str(moves)

func _on_Spot_hit():
	spot_counter -= 1
	$HUD.show_game_over_win()
	yield(get_tree().create_timer(5.0), "timeout")
	get_tree().change_scene("res://Scenes/Level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")

func _on_Deadzone_hit():
	$HUD.show_game_over_lose()
	yield(get_tree().create_timer(5.0), "timeout")
	get_tree().reload_current_scene()
