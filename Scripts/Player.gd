extends KinematicBody2D

onready var ray = $RayCast2D
onready var tween = $Tween
export var speed = 7 
var should_move = true

var tile_size = 64

# Sets player inputs based off of Godots built in input map (Project -> Project Settings -> Input Map)
var inputs = {
	"ui_right": Vector2.RIGHT,
	"ui_left": Vector2.LEFT,
	"ui_up": Vector2.UP,
	"ui_down": Vector2.DOWN
}

# Old Input Overlay - Not currently working
var No_Input = preload("res://assets/No_Input.png")
var Left_Input = preload("res://assets/Left_Input.png")
var Right_Input = preload("res://assets/Right_Input.png")
var Up_Input = preload("res://assets/Up_Input.png")
var Down_Input = preload("res://assets/Down_Input.png")

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)

func _unhandled_input(event):
	# If the player shouldn't be moving, don't move the player
	if !should_move:
		return
		
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
			move(dir)

func move(dir):
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	
	# get_collider will return null if not colliding with anything.
	# get_parent returns the parent node so we can access its `moves` property directly, there
	# is no need to creater a variable for it since it is only being used here.
	var collider = ray.get_collider()
	if !collider:
		move_tween(dir)
		get_parent().update_moves()
	else:
		if collider.is_in_group("boxes"):
			collider.move(inputs[dir])

# Moves the player in an animated sensation at the speed and amount based on tile_size and speed amount.
func move_tween(dir):
	tween.interpolate_property(self, "position",
		position, position + inputs[dir] * tile_size,
		1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
