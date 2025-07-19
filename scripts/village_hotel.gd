extends Node2D

func _ready() -> void:
	Musique.interieur = false
	if Globals.direction_from == "rue_commerce_coffee":
		$steven.position = Vector2(601, Globals.y_from)
	elif Globals.direction_from == "village_centre":
		$steven.position = Vector2(31, Globals.y_from)
	elif Globals.direction_from == "hotel":
		$steven.position = Vector2(223, 330)


func _on_goto_rue_droite_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_commerce_hotel", "rue_commerce_coffee", $steven.position.y, self)


func _on_goto_rue_gauche_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_commerce_hotel", "village_centre", $steven.position.y, self)


func _on_goto_hotel_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_commerce_hotel", "hotel", $steven.position.y, self)
