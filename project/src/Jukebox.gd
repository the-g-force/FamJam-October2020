extends AudioStreamPlayer


func toggle_mute() -> void:
	var music_bus := AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))
