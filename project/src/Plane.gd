class_name Player
extends KinematicBody2D

export var driftspeed := 200

var _is_up := false

func _physics_process(delta):
	if _is_up and rotation_degrees > -90:
		rotation_degrees -= 1
	elif not _is_up and rotation_degrees < 90:
		rotation_degrees += 1
	var speed = rotation_degrees/90
	var _error = move_and_collide(Vector2(0,driftspeed)*speed*delta)
	update()


func _input(event):
	var MouseClickEvent : InputEventMouseButton = event as InputEventMouseButton
	if MouseClickEvent && event.is_pressed():
		_is_up = true
	elif MouseClickEvent && not event.is_pressed():
		_is_up = false


func _draw():
	draw_rect(Rect2(global_position, $CollisionShape2D.shape.extents), Color.white)
