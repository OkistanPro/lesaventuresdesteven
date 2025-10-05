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
		$mode_select.visible = false

func _process(_delta: float) -> void:
	if GestionDialogue.active or Globals.in_cinematique or Globals.in_menu or Globals.in_reveil or Globals.bataille or interface.get_node("trappe").visible or interface.get_node("coffre").visible:
		visible = false
	else:
		visible = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("select"):
		if $ItemList.item_count > 0:
			if not $ItemList.get_selected_items():
				$ItemList.select(0)
				select_item_data()
				$nom_item.visible = true
				$mode_select.visible = true
				$nom_item.text = $ItemList.get_item_metadata(0).item_name
			else:
				$ItemList.deselect_all()
				Globals.selected_item = -1
				$nom_item.visible = false
				$mode_select.visible = false
	if event.is_action_pressed("inventaire_right") and $ItemList.get_selected_items():
		if $ItemList.item_count > Globals.selected_item + 1:
			$ItemList.select(Globals.selected_item + 1)
			$ItemList.ensure_current_is_visible()
			select_item_data()
			$nom_item.text = $ItemList.get_item_metadata(Globals.selected_item).item_name
	if event.is_action_pressed("inventaire_left") and $ItemList.get_selected_items():
		if Globals.selected_item > 0:
			$ItemList.select(Globals.selected_item - 1)
			$ItemList.ensure_current_is_visible()
			select_item_data()
			$nom_item.text = $ItemList.get_item_metadata(Globals.selected_item).item_name

func select_item_data() -> void:
	Globals.selected_item = $ItemList.get_selected_items()[0]
	Globals.selected_item_name = $ItemList.get_item_metadata($ItemList.get_selected_items()[0]).item_name
	print(Globals.selected_item_name)
