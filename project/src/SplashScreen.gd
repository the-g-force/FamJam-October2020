extends Node

const Game := preload("res://src/Level.tscn")

var _touched := false

func _input(event):
	if not _touched and event is InputEventMouseButton and event.is_pressed():
		$AnimationPlayer.play("FadeToBlack")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "FadeToBlack":
		var _ignored := get_tree().change_scene_to(Game)
