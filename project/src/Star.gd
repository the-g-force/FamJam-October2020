extends Area2D

signal pickup

onready var pickup := $AudioStreamPlayer2D
onready var sprite := $Sprite
onready var particles := $CPUParticles2D
onready var timer := $Timer
onready var collider := $CollisionShape2D

export var _rotation_speed := 0.5

func _ready():
	particles.emitting = false
	var _rotate := randi()%2
	if _rotate == 0:
		_rotation_speed *= -1


func _process(_delta):
	rotation_degrees += _rotation_speed


func _on_Star_body_entered(body):
	if body is Player:
		emit_signal("pickup")
		pickup.play()
		particles.emitting = true
		sprite.hide()
		timer.start()
		collider.call_deferred("set","disabled", true)


func _on_Timer_timeout():
	queue_free()
