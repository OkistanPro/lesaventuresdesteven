extends Node2D

func _ready() -> void:
	Musique.interieur = false
	if Globals.graine_regarde:
		$poussin3.nom_timeline_random[$poussin3.nom_timeline_random.find("poussin3")] = "poussin3_graines"
	if Globals.direction_from == "rue_residence_champ":
		$steven.position = Vector2(601, Globals.y_from)
		$steven.z_index = 0
	if Globals.direction_from == "poulailler":
		$steven.position = Vector2(293, 321)
		$steven.z_index = 0
	if Globals.direction_from == "ferme":
		$steven.position = Vector2(482, 272)
		$steven.z_index = 0

func _on_goto_rue_droite_body_entered(body: Node2D) -> void:
	if body == $steven:
		if Globals.parle_au_fermier:
			$poussin1.nom_timeline = "poussin1_2"
			$poussin_dead.nom_timeline = "poussin_dead2"
			Globals.goto_scene("rue_residence_ferme", "rue_residence_champ", $steven.position.y, self)
		else:
			GestionDialogue.lancer_timeline("parler_fermier")



func _on_goto_ferme_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_ferme", "poulailler", $steven.position.y, self)


func _on_goto_maison_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_ferme", "ferme", $steven.position.y, self)
		
