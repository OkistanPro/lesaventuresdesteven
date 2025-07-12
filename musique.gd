extends AudioStreamPlayer
var musique_village = preload("res://musique/OST_VILLAGEe.wav")

func _ready() -> void:
	stream = musique_village
	play()
