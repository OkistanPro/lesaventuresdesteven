extends Node2D

func _ready() -> void:
	Musique.interieur = false
	if Globals.direction_from == "rue_commerce_hotel":
		$steven.position = Vector2(31, Globals.y_from)
	if Globals.direction_from == "coffee":
		$steven.position = Vector2(245, 263)
	if Globals.direction_from == "tea":
		$steven.position = Vector2(411, 261)
		
func _on_goto_rue_gauche_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_commerce_coffee", "rue_commerce_hotel", $steven.position.y, self)


func _on_goto_coffee_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_commerce_coffee", "coffee", $steven.position.y, self)


func _on_goto_tea_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_commerce_coffee", "tea", $steven.position.y, self)
