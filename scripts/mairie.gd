extends Node2D


func _ready() -> void:
	if Globals.direction_from == "village_centre":
		$steven.position = Vector2(460, 509)
	Musique.stream = Musique.musique_mairie
	Musique.play()
	if GestionQuetes.liste_quetes["quete_clés_1.tres"].state == Quete.Quete_State.EN_COURS:
		$trappe.process_mode = Node.PROCESS_MODE_PAUSABLE
	

func _process(delta: float) -> void:
	if $steven.position.y < 320:
		$hall_entree.visible = false
		$collision_bureau.visible = true
		$hall_entree.process_mode = Node.PROCESS_MODE_DISABLED
		$collision_bureau.process_mode = Node.PROCESS_MODE_PAUSABLE
	else:
		$hall_entree.visible = true
		$collision_bureau.visible = false
		$hall_entree.process_mode = Node.PROCESS_MODE_PAUSABLE
		$collision_bureau.process_mode = Node.PROCESS_MODE_DISABLED


func _on_goto_village_body_entered(body: Node2D) -> void:
	if body == $"steven":
		Globals.goto_scene("mairie", "village_centre", 0.0, self)
