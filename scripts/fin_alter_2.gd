extends Control

func _ready() -> void:
	Musique.stop()
	Globals.in_cinematique = true



func _on_video_stream_player_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/crash_system.tscn")
