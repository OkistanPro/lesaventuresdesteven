extends AudioStreamPlayer
var musique_interieur = preload("res://musique/OST_MAISON.wav")
var musique_village = preload("res://musique/OST_VILLAGEe.wav")
var musique_cinematique = preload("res://sons/OST_CINEMATIQUE.wav")
var musique_menu = preload("res://sons/OST_MENU.wav")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	if Globals.in_cinematique:
		stream = musique_cinematique
	if Globals.in_menu:
		stream = musique_menu
	if not Globals.in_cinematique and not Globals.in_menu:
		stream = musique_village
	play()
