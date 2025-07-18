extends Control

func _ready() -> void:
	Globals.in_reveil = true


func _on_video_stream_player_finished() -> void:
	Globals.in_reveil = false
	interface.get_node("AnimationPlayer").play("fondu_blanc")
	get_tree().change_scene_to_file("res://scenes/poulailler.tscn")
	
