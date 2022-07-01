extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu_Buttons/Play_Button.grab_focus()


func _on_Start_Button_pressed():
	get_tree().change_scene("res://Scenes/Level_1.tscn")


func _on_Quit_Button_pressed():
	get_tree().quit()
	



func _on_Levels_Button_pressed():
	get_tree().change_scene("res://Scenes/Level_select.tscn")


func _on_Continue_Button_pressed():
	var pause = load("res://Scenes/Pause_Menu.tscn").instance()
	get_tree().current_scene.add_child(pause)
