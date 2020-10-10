extends Control

onready var _score_label := $ScoreLabel

func _process(_delta):
	_score_label.text = str(Score.score)
