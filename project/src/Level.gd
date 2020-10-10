extends Node2D

const Obstacle := preload("res://src/Obstacle.tscn")
const PlayerScene := preload("res://src/Player.tscn")
const Explosion := preload("res://Explosion.tscn")

export var slidespeed := 100.0

var _player : Player

onready var _obstacles := $Obstacles
onready var _obstacle_timer := $ObstacleTimer
onready var _game_over := $GameOver
onready var _airplane_selection := $AirplaneSelection


func _process(delta):
	$ParallaxBackground.scroll_offset.x -= slidespeed/2.0 * delta


func _lose():
	_game_over.visible = true
	_obstacle_timer.stop()
	var explosion := Explosion.instance()
	explosion.position = _player.position
	add_child(explosion)
	remove_child(_player)


func _on_ObstacleTimer_timeout():
	var time := rand_range(1,3)
	_obstacle_timer.start(time)
	var obstacle_number := randi()%2 + 1
	for _i in obstacle_number:
		var obstacle = Obstacle.instance()
		obstacle.position.x = 1024
		_obstacles.add_child(obstacle)
		var pos := randi()%3
		match pos:
			0:
				obstacle.position.y = 50
			1:
				obstacle.position.y = 150
			2:
				obstacle.position.y = 250
		obstacle.connect("dead", self, "_on_body_entered", [], CONNECT_ONESHOT)


func _on_body_entered(body):
	if body is Player:
		_lose()


func _on_GameOver_play_again():
	for obstacle in _obstacles.get_children():
		_obstacles.remove_child(obstacle)
	_game_over.visible = false
	_airplane_selection.visible = true


func _on_AirplaneSelection_airplane_selected(texture):
	Score.score = 0
	_airplane_selection.visible = false
	_player = PlayerScene.instance()
	_player.set_image(texture)
	_player.position = Vector2(120,300)	
	add_child(_player)
	_obstacle_timer.start()
