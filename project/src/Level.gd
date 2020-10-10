extends Node2D

const Obstacle := preload("res://src/Obstacle.tscn")
const PlayerScene := preload("res://src/Player.tscn")
const Explosion := preload("res://Explosion.tscn")
const Star := preload("res://src/Star.tscn")
const MIN_SPEED := 150
const MAX_SPEED := 250

export var slidespeed := 100.0
export var points_per_unit := 0.03

var _player : Player
var _playing := false
var _speed : float

onready var _obstacles := $Obstacles
onready var _obstacle_timer := $ObstacleTimer
onready var _game_over := $GameOver
onready var _airplane_selection := $AirplaneSelection
onready var _hud := $HUD
onready var _explosion_sound := $ExplosionSound


func _process(delta):
	$ParallaxBackground.scroll_offset.x -= slidespeed/2.0 * delta
	if _playing:
		_speed = lerp(MIN_SPEED, MAX_SPEED, cos(_player.rotation))
		Score.score += _speed * points_per_unit * delta
		for obstacle in _obstacles.get_children():
			obstacle.position.x -= _speed * delta


func _lose():
	_playing = false
	_explosion_sound.play()
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
		set_location(obstacle)
		obstacle.connect("dead", self, "_on_body_entered", [], CONNECT_ONESHOT)
#	var stars := randi()%3
#	if stars == 2:
		var star = Star.instance()
		star.position.x = 1024
		_obstacles.add_child(star)
		set_location(star)
		star.connect("pickup", self, "_pickup")


func _on_body_entered(body):
	if body is Player:
		_lose()


func _pickup():
	Score.score += 5


func set_location(item):
	var pos := randi()%3
	match pos:
		0:
			item.position.y = 50
		1:
			item.position.y = 150
		2:
			item.position.y = 250


func _on_GameOver_play_again():
	_hud.visible = false
	for obstacle in _obstacles.get_children():
		_obstacles.remove_child(obstacle)
	_game_over.visible = false
	_airplane_selection.visible = true


func _on_AirplaneSelection_airplane_selected(texture):
	Score.score = 0
	_hud.visible = true
	_airplane_selection.visible = false
	_player = PlayerScene.instance()
	_player.set_image(texture)
	_player.position = Vector2(120,300)	
	add_child(_player)
	_obstacle_timer.start()
	_playing = true
