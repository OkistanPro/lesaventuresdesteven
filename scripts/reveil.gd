extends Control

func _ready() -> void:
	Globals.in_reveil = true
	if GestionsEvents.current_event == "event_alter1":
		$VideoStreamPlayer.stream = preload("res://videos/reveil_steven_alter1_ntsc.ogv")
		$VideoStreamPlayer.play()


func _on_video_stream_player_finished() -> void:
	Globals.in_reveil = false
	interface.get_node("AnimationPlayer").play("fondu_blanc")
	get_tree().change_scene_to_file("res://scenes/poulailler.tscn")
	
