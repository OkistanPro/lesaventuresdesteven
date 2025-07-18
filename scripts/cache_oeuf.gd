extends Polygon2D

var in_area : bool
var oeuf_pris : bool = false
var oeuf_item : ItemProperties = preload("res://items/oeuf.tres")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == $"../steven" and not oeuf_pris and GestionQuetes.liste_quetes["quete_oeufs_1.tres"].state == Quete.Quete_State.EN_COURS:
		in_area = true
		$Polygon2D.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == $"../steven" and not oeuf_pris and GestionQuetes.liste_quetes["quete_oeufs_1.tres"].state == Quete.Quete_State.EN_COURS:
		in_area = false
		$Polygon2D.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interagir") and in_area:
		if not oeuf_pris and GestionQuetes.liste_quetes["quete_oeufs_1.tres"].state == Quete.Quete_State.EN_COURS:
			color.a = 1.0
			Globals.pick_item(oeuf_item)
			GestionSons.play_sound("collect_item")
			$Polygon2D.visible = false
			oeuf_item.picked = true
			oeuf_pris = true
