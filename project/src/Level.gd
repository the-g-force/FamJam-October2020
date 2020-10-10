extends Node2D

const Obstacle = preload("res://src/Obstacle.tscn")

signal dead

var slidespeed := 100.0

onready var player := $Plane
onready var obstacles := $Obstacles
onready var obstacle_timer := $ObstacleTimer

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


func _on_ObstacleTimer_timeout():
	var time := rand_range(1,3)
	obstacle_timer.start(time)
	var obstacle_number := randi()%2 + 1
	for _i in obstacle_number:
		var obstacle = Obstacle.instance()
		obstacle.position.x = 650
		obstacles.add_child(obstacle)
		var pos := randi()%3
		match pos:
			0:
				obstacle.position.y = 50
			1:
				obstacle.position.y = 150
			2:
				obstacle.position.y = 250
