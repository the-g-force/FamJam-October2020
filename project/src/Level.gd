extends Node2D

const Obstacle := preload("res://src/Obstacle.tscn")
const PlayerScene := preload("res://src/Player.tscn")
const Explosion := preload("res://Explosion.tscn")
const Star := preload("res://src/Star.tscn")
const TIME_BETWEEN_BALLOONS := 3
const TIME_BETWEEN_STARS := 4
const MIN_SPEED := 150
const MAX_SPEED := 250
const MAX_HEIGHT := 85
const MIN_HEIGHT := 510

export var slidespeed := 100.0
export var points_per_unit := 0.03
export var star_points := 50

var _player : Player
var _playing := false
var _speed : float
var _balloontime : float = TIME_BETWEEN_BALLOONS
var _startime : float = TIME_BETWEEN_STARS

onready var _obstacles := $Obstacles
onready var _obstacle_timer := $ObstacleTimer
onready var _game_over := $GameOver
onready var _airplane_selection := $AirplaneSelection
onready var _hud := $HUD
onready var _explosion_sound := $ExplosionSound
onready var _star_timer := $StarTimer


func _ready():
	Jukebox.play()


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
	_star_timer.stop()
	var explosion := Explosion.instance()
	explosion.position = _player.position
	add_child(explosion)
	remove_child(_player)


func _on_ObstacleTimer_timeout():
	_balloontime *= 0.95
	_obstacle_timer.start(_balloontime)
	var obstacle = Obstacle.instance()
	obstacle.position.x = 1024
	_obstacles.add_child(obstacle)
	set_location(obstacle)
	obstacle.connect("dead", self, "_on_body_entered", [], CONNECT_ONESHOT)


func _on_body_entered(body):
	if body is Player:
		_lose()


func _pickup():
	Score.score += star_points


func set_location(item):
	item.position.y = lerp(MIN_HEIGHT, MAX_HEIGHT, randf())


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
	_balloontime = TIME_BETWEEN_BALLOONS
	_startime = TIME_BETWEEN_STARS
	_obstacle_timer.start()
	_star_timer.start()
	_playing = true


func _on_StarTimer_timeout():
	_startime *= 1.05
	_star_timer.start(_startime)
	var star = Star.instance()
	star.position.x = 1024
	_obstacles.add_child(star)
	set_location(star)
	star.connect("pickup", self, "_pickup")
