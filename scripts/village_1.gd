extends Node2D

func _ready() -> void:
	if Globals.direction_from == "rue_commerce_epicerie":
		$steven.position = Vector2(31, Globals.y_from)
	if Globals.direction_from == "rue_commerce_hotel":
		$steven.position = Vector2(601, Globals.y_from)


func _on_goto_rue_gauche_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("village_centre", "rue_commerce_epicerie", $steven.position.y)


func _on_goto_rue_droite_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("village_centre", "rue_commerce_hotel", $steven.position.y)
