extends Area2D

export var slidespeed := 100


func _process(delta):
	if position.x > -50:
		position.x -= slidespeed*delta
		update()
	else:
		queue_free()


func _draw():
	draw_rect(Rect2($CollisionShape2D.shape.extents*-1, $CollisionShape2D.shape.extents*2), Color.black)
