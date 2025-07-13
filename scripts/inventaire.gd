extends Control

func _ready() -> void:
	Globals.inventory_changed.connect(refresh_list)
	refresh_list(null)

func refresh_list(added : ItemProperties) -> void:
	if added:
		$TextureRect.texture = added.texture_icon
		$TextureRect.visible = true
		$Label.text = added.item_name
		$AnimationPlayer.play("new_item")
		await $AnimationPlayer.animation_finished
	$ItemList.clear()
	for item in Globals.inventory:
		$ItemList.add_icon_item(item.texture_icon)

func _process(delta: float) -> void:
	if GestionDialogue.active:
		visible = false
	else:
		visible = true
