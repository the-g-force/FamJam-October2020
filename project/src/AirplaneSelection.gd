extends Control

var _images := [
	preload("res://assets/Planes/TestPlane.png")
]

onready var _button_container := $ButtonContainer

func _ready():
	for plane in _images:
		var button := TextureButton.new()
		button.texture_normal = plane
		_button_container.add_child(button)
		var _ignored := button.connect("pressed", self, "_on_Button_pressed", [plane], CONNECT_ONESHOT)
		
		
func _on_Button_pressed(texture):
	print('Pressed ' + str(texture))
