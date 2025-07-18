extends Node2D

func _ready() -> void:
	Musique.interieur = false
	if Globals.direction_from == "rue_commerce_hotel":
		$steven.position = Vector2(31, Globals.y_from)

func _on_goto_rue_gauche_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_commerce_coffee", "rue_commerce_hotel", $steven.position.y, self)
