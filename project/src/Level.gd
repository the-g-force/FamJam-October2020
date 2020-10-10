extends Node2D

signal dead

var slidespeed := 100.0

onready var player := $Plane

func _restart():
	player.position = Vector2(100, 150)
	player.rotation_degrees = 0


func _process(delta):
	$ParallaxBackground.scroll_offset.x -= slidespeed/2.0 * delta


func _on_Wall1_body_entered(body):
	if body is Player:
		emit_signal("dead")
		_restart()


func _on_Wall2_body_entered(body):
	if body is Player:
		emit_signal("dead")
		_restart()
