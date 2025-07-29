extends Node2D

func _ready() -> void:
	Musique.interieur = true
	if Globals.direction_from == "rue_commerce_souvenirs":
		$steven.position = Vector2(452, 423)
	GestionSons.play_sound("ding_epicerie")


func _on_goto_rue_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("souvenirs", "rue_commerce_souvenirs", 0.0, self)
