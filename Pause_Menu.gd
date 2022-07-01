extends Control

func _ready():
	$Menu_Buttons/Levels_Button.grab_focus()

func _on_Levels_Button_pressed():
	get_tree().change_scene("res://Scenes/Level_select.tscn")
	

func _on_Quit_Button_pressed():
	get_tree().quit()


func _on_MainMenu_Button_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
