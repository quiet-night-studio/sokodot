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

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
#	position += Vector2.ONE * tile_size/2 -- Doesnt work because of the player anchor

var No_Input = preload("res://assets/No_Input.png")
var Left_Input = preload("res://assets/Left_Input.png")
var Right_Input = preload("res://assets/Right_Input.png")
var Up_Input = preload("res://assets/Up_Input.png")
var Down_Input = preload("res://assets/Down_Input.png")
func _unhandled_input(event):
	if tween.is_active():
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()
	if event.is_action_pressed("ui_left"):
		get_parent().get_node("Inputs/Input").set_texture(Left_Input)
	elif event.is_action_pressed("ui_right"):
		get_parent().get_node("Inputs/Input").set_texture(Right_Input)
	elif event.is_action_pressed("ui_up"):
		get_parent().get_node("Inputs/Input").set_texture(Up_Input)
	elif event.is_action_pressed("ui_down"):
		get_parent().get_node("Inputs/Input").set_texture(Down_Input)

# Same as the countdown code, there 100 is a better way to write this. It is again 12am though.
# I would like to properly implement this in the future.

func move(dir):
	var game = get_parent()
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
#		position += dir * tile_size
		move_tween(dir)
		game.moves += 1
	else:
		var collider = ray.get_collider()
		if collider.is_in_group("boxes"):
			collider.move(inputs[dir])
			game.moves += 1

func move_tween(dir):
	tween.interpolate_property(self, "position",
		position, position + inputs[dir] * tile_size,
		1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
