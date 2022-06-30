extends Area2D

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
	#position += Vector2.ONE * tile_size/2 -- Doesnt work because of the player anchor

func _unhandled_input(event):
	if tween.is_active():
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir) # "ui_down"

func move(dir):
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
#		position += dir * tile_size
		move_tween(dir)
	else:
		var collider = ray.get_collider()
		if collider.is_in_group("boxes"):
			collider.move(inputs[dir])

func move_tween(dir):
	tween.interpolate_property(self, "position",
		position, position + inputs[dir] * tile_size,
		1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
