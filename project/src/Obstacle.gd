extends Area2D

signal dead(body)

export var slidespeed := 100


func _process(delta):
	if position.x < -50:
		queue_free()


func _draw():
	draw_rect(Rect2(Vector2.ZERO, $CollisionShape2D.shape.extents*2), Color.black)


func _on_Obstacle_body_entered(body):
	if body is Player:
		emit_signal("dead", body)
