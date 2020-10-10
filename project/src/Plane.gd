extends KinematicBody2D

export var driftspeed := 50

var _is_up := false

func _physics_process(delta):
	var dirmod := 1
	if _is_up:
		dirmod = -1
	elif not _is_up:
		dirmod = 1
	move_and_collide(Vector2(0, driftspeed)*dirmod*delta)


func _input(event):
	var MouseClickEvent : InputEventMouseButton = event as InputEventMouseButton
	if MouseClickEvent && event.is_pressed():
		_is_up = true
	elif MouseClickEvent && not event.is_pressed():
		_is_up = false


func _draw():
	draw_circle(position, $CollisionShape2D.shape.radius, Color.white)
