extends KinematicBody2D

onready var ray = $RayCast2D
onready var tween = $Tween
export var speed = 7 

var tile_size = 64

var inputs = {
	"ui_right": Vector2.RIGHT,
	"ui_left": Vector2.LEFT,
	"ui_up": Vector2.UP,
	"ui_down": Vector2.DOWN
}

var No_Input = preload("res://assets/No_Input.png")
var Left_Input = preload("res://assets/Left_Input.png")
var Right_Input = preload("res://assets/Right_Input.png")
var Up_Input = preload("res://assets/Up_Input.png")
var Down_Input = preload("res://assets/Down_Input.png")

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	# Doesnt work because the player sprite is not centered (offset).
	# position += Vector2.ONE * tile_size/2

func _unhandled_input(event):
	# If the transition animation is happening, don't move the player
	if tween.is_active():
		return

	# Reset the game
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()

	# Pause the game
	if event.is_action_pressed("pause"):
		get_tree().change_scene("res://Scenes/Pause_Menu.tscn")

	# Move the player
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
#			match(dir):
#				"ui_left":
#					get_parent().get_node("Inputs/Input").set_texture(Left_Input)
#				"ui_right":
#					get_parent().get_node("Inputs/Input").set_texture(Right_Input)
#				"ui_up":
#					get_parent().get_node("Inputs/Input").set_texture(Up_Input)
#				"ui_down":
#					get_parent().get_node("Inputs/Input").set_texture(Down_Input)
			move(dir)

func move(dir):
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	
	# get_collider will return null if not colliding with anything.
	var collider = ray.get_collider()
	if !collider:
		move_tween(dir)
		get_parent().update_moves()
		# get_parent returns the parent node so we can access its `moves` property directly, there
		# is no need to creater a variable for it since it is only being used here.
		
		# get_parent().moves += 1
		#get_parent().get_parent().update_moves()
	else:
		if collider.is_in_group("boxes"):
			collider.move(inputs[dir])

func move_tween(dir):
	tween.interpolate_property(self, "position",
		position, position + inputs[dir] * tile_size,
		1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
