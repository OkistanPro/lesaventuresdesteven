extends Node2D

func _ready() -> void:
	Musique.interieur = true
	if Globals.direction_from == "rue_commerce_epicerie":
		$steven.position = Vector2(568, 427)
	GestionSons.play_sound("ding_epicerie")
	if GestionQuetes.liste_quetes["quete_clés_1.tres"].state == Quete.Quete_State.EN_COURS:
		if get_node_or_null("Cle4"):
			$Cle4.visible = true
			$Cle4.properties.pickable = true

func _on_goto_rue_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("epicerie", "rue_commerce_epicerie", 0.0, self)
