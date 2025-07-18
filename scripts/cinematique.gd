extends Control

var texte_cinematique : Array[String] = [
	"Dans un village tyrannisé...",
	"...où les habitants sont exploités...",
	"...où règne la terreur et le massacre...",
	"...le sort du village dépendra d'un seul et unique...",
	"...poussin.",
	"Attends, poussin ?"
]

func _ready() -> void:
	Globals.in_cinematique = true
	Globals.in_menu = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	await Musique.finished
	skip()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interagir"):
		skip()

func skip() -> void:
	Globals.in_cinematique = false
	Globals.in_menu = true
	Musique.stop()
	Musique.stream = Musique.musique_menu
	Musique.play()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
