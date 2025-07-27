extends Node2D

func _ready() -> void:
	Musique.interieur = true
	if Globals.direction_from == "rue_commerce_coffee":
		$steven.position = Vector2(407, 452)
	
	if GestionQuetes.liste_quetes["quete_café_1.tres"].state == Quete.Quete_State.EN_COURS:
		$Cyprien.position = Vector2(468, 220)
		$Cyprien.flip_h = true
		$Cyprien.region_enabled = false
		$Cyprien.nom_timeline = ""
		$Cyprien.texture = preload("res://sprites/persos/RPG-PERSO-PRINCIPEAU(2)_0001_cyprien_dos.png")
		$Cyprien/ecouteur_gauche.visible = true
		$Cyprien/ecouteur_droite.visible = true
	#468 200
	if Globals.dialogue_bataille_passed:
		$Cyprien.visible = false
		$Cyprien.process_mode = Node.PROCESS_MODE_DISABLED

func _on_goto_rue_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("tea", "rue_commerce_coffee", 0.0, self)
