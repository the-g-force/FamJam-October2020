extends AudioStreamPlayer


func toggle_mute() -> void:
	AudioServer.set_bus_mute(0, not AudioServer.is_bus_mute(0))
