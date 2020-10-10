extends VBoxContainer

signal play_again

func _on_PlayAgainButton_pressed():
	emit_signal("play_again")
