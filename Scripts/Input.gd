extends Sprite

var default = preload("res://assets/No_Input.png")
var left = preload("res://assets/Left_Input.png")
var right = preload("res://assets/Right_Input.png")
var down = preload("res://assets/Down_Input.png")
var up = preload("res://assets/Up_Input.png")


func _input(event):
#	If the key is being pressed
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_UP:
			texture = up
		if event.scancode == KEY_DOWN:
			texture = down
		if event.scancode == KEY_LEFT:
			texture = left
		if event.scancode == KEY_RIGHT:
			texture = right
			
#	If the key is not being pressed
	if event is InputEventKey and !event.pressed:
		if event.scancode == KEY_UP:
			texture = default
		if event.scancode == KEY_DOWN:
			texture = default
		if event.scancode == KEY_LEFT:
			texture = default
		if event.scancode == KEY_RIGHT:
			texture = default
