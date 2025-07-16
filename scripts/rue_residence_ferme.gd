extends Node2D

func _ready() -> void:
	if Globals.direction_from == "rue_residence_champ":
		$steven.position = Vector2(601, Globals.y_from)
		$steven.z_index = 0

func _on_goto_rue_droite_body_entered(body: Node2D) -> void:
	if body == $steven and Globals.parle_au_fermier:
		Globals.goto_scene("rue_residence_ferme", "rue_residence_champ", $steven.position.y)


func _on_goto_ferme_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_ferme", "poulailler", $steven.position.y)
