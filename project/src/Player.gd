class_name Player
extends KinematicBody2D

export var driftspeed := 200
export var turnspeed := 2

var _is_up := false

func _physics_process(delta):
	if _is_up and rotation_degrees > -90:
		rotation_degrees -= turnspeed
	elif not _is_up and rotation_degrees < 90:
		rotation_degrees += turnspeed
	var speed = rotation_degrees/90
	var _error = move_and_collide(Vector2(0,driftspeed)*speed*delta)
	update()


func _input(event):
	var MouseClickEvent : InputEventMouseButton = event as InputEventMouseButton
	if MouseClickEvent && event.is_pressed():
		_is_up = true
	elif MouseClickEvent && not event.is_pressed():
		_is_up = false


func set_image(image) -> void:
	$Sprite.texture = image
