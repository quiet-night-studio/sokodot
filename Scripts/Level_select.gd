extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu_Buttons/Level1_Button.grab_focus()
	
	


func _on_Level1_Button_pressed():
	get_tree().change_scene("res://Scenes/Level_1.tscn")


func _on_Level2_Button_pressed():
	get_tree().change_scene("res://Scenes/Level_2.tscn")


func _on_Level3_Button_pressed():
	get_tree().change_scene("res://Scenes/Level_3.tscn")


func _on_Return_Button_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
