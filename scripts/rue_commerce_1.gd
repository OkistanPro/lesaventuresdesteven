extends Node2D

func _ready() -> void:
	Musique.interieur = false
	if Globals.direction_from == "rue_commerce_epicerie":
		$steven.position = Vector2(601, Globals.y_from)


func _on_goto_rue_droite_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_commerce_souvenirs", "rue_commerce_epicerie", $steven.position.y, self)
