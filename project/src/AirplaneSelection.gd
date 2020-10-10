extends Control

signal airplane_selected(texture)

var _images := [
	preload("res://assets/Planes/b-29-D.png"),
	preload("res://assets/Planes/plane-Leo.png")
]

onready var _button_container := $VBoxContainer/ButtonContainer


func _ready():
	for plane in _images:
		var button := TextureButton.new()
		button.texture_normal = plane
		_button_container.add_child(button)
		var _ignored := button.connect("pressed", self, "_on_Button_pressed", [plane], CONNECT_ONESHOT)
		
		
func _on_Button_pressed(texture):
	emit_signal("airplane_selected", texture)
