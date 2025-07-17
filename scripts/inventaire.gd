extends Control

var theme_select = StyleBoxFlat.new()

func _ready() -> void:
	Globals.inventory_changed.connect(refresh_list)
	refresh_list(null)
	
	theme_select.bg_color = Color.GOLDENROD
	theme_select.bg_color.a = 0.5

func refresh_list(added : ItemProperties) -> void:
	if added != null:
		$TextureRect.texture = added.texture_icon
		$TextureRect.visible = true
		$Label.text = added.item_name
		$AnimationPlayer.play("new_item")
		await $AnimationPlayer.animation_finished
	$ItemList.clear()
	for item in Globals.inventory:
		var index = $ItemList.add_icon_item(item.texture_icon)
		$ItemList.set_item_metadata(index, item)
	if not $ItemList.get_selected_items() or ($ItemList.get_selected_items() and $ItemList.item_count > $ItemList.get_selected_items()[0]):
		Globals.selected_item = -1
		$nom_item.visible = false

func _process(delta: float) -> void:
	if GestionDialogue.active or Globals.in_cinematique or Globals.in_menu:
		visible = false
	else:
		visible = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inv_1"):
		if $ItemList.item_count > 0:
			if 0 not in $ItemList.get_selected_items():
				$ItemList.select(0)
				select_item_data()
				$nom_item.visible = true
				$nom_item.text = $ItemList.get_item_metadata(0).item_name
			else:
				$ItemList.deselect(0)
				Globals.selected_item = -1
				$nom_item.visible = false
	if event.is_action_pressed("inv_2"):
		if $ItemList.item_count > 1:
			if 1 not in $ItemList.get_selected_items():
				$ItemList.select(1)
				select_item_data()
				$nom_item.visible = true
				$nom_item.text = $ItemList.get_item_metadata(1).item_name
			else:
				$ItemList.deselect(1)
				Globals.selected_item = -1
				$nom_item.visible = false
	if event.is_action_pressed("inv_3"):
		if $ItemList.item_count > 2:
			if 2 not in $ItemList.get_selected_items():
				$ItemList.select(2)
				select_item_data()
				$nom_item.visible = true
				$nom_item.text = $ItemList.get_item_metadata(2).item_name
			else:
				$ItemList.deselect(2)
				Globals.selected_item = -1
				$nom_item.visible = false
	if event.is_action_pressed("inv_4"):
		if $ItemList.item_count > 3:
			if 3 not in $ItemList.get_selected_items():
				$ItemList.select(3)
				select_item_data()
				$nom_item.visible = true
				$nom_item.text = $ItemList.get_item_metadata(3).item_name
			else:
				$ItemList.deselect(3)
				Globals.selected_item = -1
				$nom_item.visible = false
	if event.is_action_pressed("inv_5"):
		if $ItemList.item_count > 4:
			if 4 not in $ItemList.get_selected_items():
				$ItemList.select(4)
				select_item_data()
				$nom_item.visible = true
				$nom_item.text = $ItemList.get_item_metadata(4).item_name
			else:
				$ItemList.deselect(4)
				Globals.selected_item = -1
				$nom_item.visible = false
	if event.is_action_pressed("inv_6"):
		if $ItemList.item_count > 5:
			if 5 not in $ItemList.get_selected_items():
				$ItemList.select(5)
				select_item_data()
				$nom_item.visible = true
				$nom_item.text = $ItemList.get_item_metadata(5).item_name
			else:
				$ItemList.deselect(5)
				Globals.selected_item = -1
				$nom_item.visible = false
	if event.is_action_pressed("inv_7"):
		if $ItemList.item_count > 6:
			if 6 not in $ItemList.get_selected_items():
				$ItemList.select(6)
				select_item_data()
				$nom_item.visible = true
				$nom_item.text = $ItemList.get_item_metadata(6).item_name
			else:
				$ItemList.deselect(6)
				Globals.selected_item = -1
				$nom_item.visible = false
	if event.is_action_pressed("inv_8"):
		if $ItemList.item_count > 7:
			if 7 not in $ItemList.get_selected_items():
				$ItemList.select(7)
				select_item_data()
				$nom_item.visible = true
				$nom_item.text = $ItemList.get_item_metadata(7).item_name
			else:
				$ItemList.deselect(7)
				Globals.selected_item = -1
				$nom_item.visible = false

func select_item_data() -> void:
	Globals.selected_item = $ItemList.get_selected_items()[0]
	Globals.selected_item_name = $ItemList.get_item_metadata($ItemList.get_selected_items()[0]).item_name
	print(Globals.selected_item_name)
