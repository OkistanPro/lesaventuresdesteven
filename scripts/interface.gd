extends CanvasLayer

var in_quetes : bool = false
var anim_quete_scene = preload("res://scenes/animation_quete.tscn")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	GestionDialogue.lancer_dialogue.connect(lancer_dialogue)

func lancer_dialogue() -> void:
	add_child(GestionDialogue.dialogue_scene.instantiate())

func fen_quetes() -> void:
	if not in_quetes:
		$"Quêtes".visible = true
		in_quetes = true
	else:
		$"Quêtes".visible = false
		in_quetes = false

func anim_quete(nom_quete : String) -> void:
	var new_anim_quete_instance = anim_quete_scene.instantiate()
	new_anim_quete_instance.get_node("HFlowContainer/nom_quete").text = nom_quete
	add_child(new_anim_quete_instance)
