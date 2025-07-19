extends Node2D

func _ready() -> void:
	Musique.interieur = true
	if Globals.direction_from == "rue_commerce_hotel":
		$steven.position = Vector2(395, 447)
	GestionDialogue.event_declencheur.connect(event)


func _on_goto_rue_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("hotel", "rue_commerce_hotel", $steven.position.y, self)


func _on_fleche_body_entered(body: Node2D) -> void:
	$Polygon2D.visible = true


func _on_fleche_body_exited(body: Node2D) -> void:
	$Polygon2D.visible = false

func event(nom_event : String) -> void:
	if nom_event == "lancement_quete_hotel":
		$balai.properties.pickable = true
