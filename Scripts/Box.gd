extends KinematicBody2D

var tile_size = 64
export var speed = 7

onready var tween = $Tween
onready var ray = $RayCast2D

func move(dir):
	ray.cast_to = dir * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		move_tween(dir)
		return true
	return false

func move_tween(dir):
	tween.interpolate_property(self, "position",
		position, position + dir * tile_size,
		1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
