extends Node2D

func _ready() -> void:
	Musique.interieur = false
	if Globals.direction_from == "croisement_residence":
		$steven.position = Vector2(Globals.y_from, 650)
	if Globals.direction_from == "rue_commerce_epicerie":
		$steven.position = Vector2(31, Globals.y_from)
	if Globals.direction_from == "rue_commerce_hotel":
		$steven.position = Vector2(601, Globals.y_from)


func _on_goto_rue_gauche_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("village_centre", "rue_commerce_epicerie", $steven.position.y, self)


func _on_goto_rue_droite_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("village_centre", "rue_commerce_hotel", $steven.position.y, self)


func _on_goto_rue_bas_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("village_centre", "croisement_residence", $steven.position.x, self)
