extends Area2D

signal dead(body)

func _ready():
	$Sprite.frame = randi() % 8
	

func _process(_delta):
	if position.x < -50:
		queue_free()


func _on_Obstacle_body_entered(body):
	if body is Player:
		emit_signal("dead", body)
