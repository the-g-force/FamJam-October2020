extends Node2D

onready var player := $Plane

func _restart():
	player.position = Vector2(100, 150)
	player.rotation_degrees = 0


func _on_Wall1_body_entered(body):
	if body is Player:
		_restart()


func _on_Wall2_body_entered(body):
	if body is Player:
		_restart()
