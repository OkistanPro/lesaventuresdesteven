extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "Appuyer sur " + InputMap.action_get_events("cancel")[0].as_text() + " pour revenir."
