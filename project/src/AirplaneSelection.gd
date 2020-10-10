extends Control

signal airplane_selected(texture)
tool

var _images := [
	preload("res://assets/Planes/b-29-D.png"),
	preload("res://assets/Planes/biplane1.png"),
	preload("res://assets/Planes/biplane2.png"),
	preload("res://assets/Planes/jet1.png"),
	preload("res://assets/Planes/jet2.png"),
	preload("res://assets/Planes/jet3.png"),
	preload("res://assets/Planes/passenger.png"),
	preload("res://assets/Planes/passenger2.png"),
	preload("res://assets/Planes/plane-D.png"),
	preload("res://assets/Planes/plane-Leo.png"),
	preload("res://assets/Planes/plane0D.png")
]

onready var _button_container := $VBoxContainer/ButtonContainer


func _ready():
	for plane in _images:
		var button := TextureButton.new()
		button.texture_normal = plane
		_button_container.add_child(button)
		var _ignored := button.connect("pressed", self, "_on_Button_pressed", [plane])
		
		
func _on_Button_pressed(texture):
	emit_signal("airplane_selected", texture)


func _on_MuteButton_pressed():
	$Jukebox.toggle_mute()


func _on_FullscreenButton_pressed():
	OS.window_fullscreen = not OS.window_fullscreen
