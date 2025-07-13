extends Control

func _ready() -> void:
	Globals.inventory_changed.connect(refresh_list)
	refresh_list()

func refresh_list() -> void:
	$ItemList.clear()
	for item in Globals.inventory:
		$ItemList.add_icon_item(item.texture_icon)

func _process(delta: float) -> void:
	if GestionDialogue.active:
		visible = false
	else:
		visible = true
