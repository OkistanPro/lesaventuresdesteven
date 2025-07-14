extends Control

var theme_select = StyleBoxFlat.new()

func _ready() -> void:
	if Globals.in_menu:
		queue_free()
	Globals.inventory_changed.connect(refresh_list)
	refresh_list(null)
	
	theme_select.bg_color = Color.GOLDENROD
	theme_select.bg_color.a = 0.5

func refresh_list(added : ItemProperties) -> void:
	if added:
		$TextureRect.texture = added.texture_icon
		$TextureRect.visible = true
		$Label.text = added.item_name
		$AnimationPlayer.play("new_item")
		await $AnimationPlayer.animation_finished
	$ItemList.clear()
	for item in Globals.inventory:
		var index = $ItemList.add_icon_item(item.texture_icon)
		$ItemList.set_item_metadata(index, item)

func _process(delta: float) -> void:
	if GestionDialogue.active:
		visible = false
	else:
		visible = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("select_inventaire"):
		if Globals.selected_item == -1:
			Globals.selected_item = $ItemList.get_selected_items()[0]
			Globals.selected_item_name = $ItemList.get_item_metadata($ItemList.get_selected_items()[0]).item_name
			print(Globals.selected_item_name)
			$ItemList.add_theme_stylebox_override("selected", theme_select)
		else:
			Globals.selected_item = -1
			$ItemList.remove_theme_stylebox_override("selected")
	if event.is_action_pressed("inv_1"):
		if $ItemList.item_count > 0:
			$ItemList.select(0)
	if event.is_action_pressed("inv_2"):
		if $ItemList.item_count > 1:
			$ItemList.select(1)
	if event.is_action_pressed("inv_3"):
		if $ItemList.item_count > 2:
			$ItemList.select(2)
	if event.is_action_pressed("inv_4"):
		if $ItemList.item_count > 3:
			$ItemList.select(3)
	if event.is_action_pressed("inv_5"):
		if $ItemList.item_count > 4:
			$ItemList.select(4)
	if event.is_action_pressed("inv_6"):
		if $ItemList.item_count > 5:
			$ItemList.select(5)
	if event.is_action_pressed("inv_7"):
		if $ItemList.item_count > 6:
			$ItemList.select(6)
	if event.is_action_pressed("inv_8"):
		if $ItemList.item_count > 7:
			$ItemList.select(7)
