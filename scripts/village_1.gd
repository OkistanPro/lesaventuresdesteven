extends Node2D

func _ready() -> void:
	if Globals.direction_from == "rue_commerce_gauche":
		$steven.position = Vector2(31, 322)
	if Globals.direction_from == "rue_commerce_droite":
		$steven.position = Vector2(601, 322)


func _on_goto_rue_gauche_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("village_centre", "rue_commerce_gauche")


func _on_goto_rue_droite_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("village_centre", "rue_commerce_droite")
