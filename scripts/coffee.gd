extends Node2D

func _ready() -> void:
	Musique.interieur = true
	if Globals.direction_from == "rue_commerce_coffee":
		$steven.position = Vector2(394, 444)
	if GestionQuetes.liste_quetes["quete_colis_1.tres"].state == Quete.Quete_State.FINI:
		$Squeezie.nom_timeline = "gerant_cafe_quete"
	if GestionQuetes.liste_quetes["quete_thé_1.tres"].state == Quete.Quete_State.EN_COURS:
		$Squeezie.position = Vector2(340, 220)
		$Squeezie.flip_h = false
		$Squeezie.region_enabled = false
		$Squeezie.texture = preload("res://sprites/persos/RPG-PERSO-PRINCIPEAU(2)_0000_squeezie_dos.png")
		$Squeezie/ecouteur_gauche.visible = true
		$Squeezie/ecouteur_droite.visible = true

func _on_goto_rue_body_entered(body: Node2D) -> void:
	if body == $steven:
		Globals.goto_scene("coffee", "rue_commerce_coffee", 0.0, self)
