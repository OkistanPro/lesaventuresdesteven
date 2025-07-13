extends Node2D

func _ready() -> void:
	if Globals.direction_from == "village_centre":
		$steven.position = Vector2(601, Globals.y_from)
	elif Globals.direction_from == "rue_commerce_souvenirs":
		$steven.position = Vector2(31, Globals.y_from)


func _on_goto_rue_droite_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_commerce_epicerie", "village_centre", $steven.position.y)


func _on_goto_rue_gauche_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_commerce_epicerie", "rue_commerce_souvenirs", $steven.position.y)
