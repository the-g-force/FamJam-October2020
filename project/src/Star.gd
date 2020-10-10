extends Area2D

signal pickup

export var _rotation_speed := 0.5

func _ready():
	var _rotate := randi()%2
	if _rotate == 0:
		_rotation_speed *= -1


func _process(_delta):
	rotation_degrees += _rotation_speed


func _on_Star_body_entered(body):
	if body is Player:
		emit_signal("pickup")
		queue_free()
