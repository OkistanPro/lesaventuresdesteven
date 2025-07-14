extends AudioStreamPlayer
var musique_village = preload("res://musique/OST_VILLAGEe.wav")
var musique_cinematique = preload("res://sons/OST_CINEMATIQUE.wav")

func _ready() -> void:
	if Globals.in_menu:
		stream = musique_cinematique
	else:
		stream = musique_village
	play()
