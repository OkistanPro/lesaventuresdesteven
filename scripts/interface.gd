extends CanvasLayer

func _ready() -> void:
	GestionDialogue.lancer_dialogue.connect(lancer_dialogue)

func lancer_dialogue() -> void:
	add_child(GestionDialogue.dialogue_scene.instantiate())
