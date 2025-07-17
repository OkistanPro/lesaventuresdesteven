extends Node2D

var montre = preload("res://scenes/montre.tscn")

func _ready() -> void:
	Globals.event_declencheur.connect(_montre)
	if Globals.direction_from == "croisement_residence":
		$steven.position = Vector2(30, Globals.y_from+80.0)
	if Globals.direction_from == "rue_residence_parc2":
		$steven.position = Vector2(601, Globals.y_from)

func _on_goto_rue_gauche_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_parc1", "croisement_residence", $steven.position.y, self)


func _on_goto_rue_droite_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("rue_residence_parc1", "rue_residence_parc2", $steven.position.y, self)

func _montre(nom_event  : String) -> void:
	if nom_event == "montre":
		var montre_instance = montre.instantiate()
		$trou_de_terre6.add_child(montre_instance)
		$trou_de_terre6.properties.event_on_not_pick = &"trou_vide"
		montre_instance.reparent(self)
		$trou_de_terre6/Polygon2D.visible = false
		$trou_de_terre6/Area2D.monitoring = false
