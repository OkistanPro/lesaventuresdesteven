extends Control

var wait_input : bool = false
var wait_input_action_name : String

func _ready() -> void:
	var quality = ProjectSettings.get_setting("display/window/stretch/mode")
	match quality:
		"canvas_items":
			$options/Panel/VBoxContainer/qualite/OptionButton.select(1)
		"viewport":
			$options/Panel/VBoxContainer/qualite/OptionButton.select(0)
	
	$options/Panel/VBoxContainer/musique/HSlider.value = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Musique"))*100
	$options/Panel/VBoxContainer/sfx/HSlider.value = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("SFX"))*100
	
	$controles/Panel/HBoxContainer/VBoxContainer/control_instance/Button.text = InputMap.action_get_events("up")[0].as_text()
	$controles/Panel/HBoxContainer/VBoxContainer/control_instance2/Button.text = InputMap.action_get_events("down")[0].as_text()
	$controles/Panel/HBoxContainer/VBoxContainer/control_instance3/Button.text = InputMap.action_get_events("left")[0].as_text()
	$controles/Panel/HBoxContainer/VBoxContainer/control_instance4/Button.text = InputMap.action_get_events("right")[0].as_text()
	$controles/Panel/HBoxContainer/VBoxContainer/control_instance5/Button.text = InputMap.action_get_events("run")[0].as_text()
	$controles/Panel/HBoxContainer/VBoxContainer/control_instance6/Button.text = InputMap.action_get_events("interagir")[0].as_text()
	$controles/Panel/HBoxContainer/VBoxContainer/control_instance7/Button.text = InputMap.action_get_events("cancel")[0].as_text()
	$controles/Panel/HBoxContainer/VBoxContainer2/control_instance/Button.text = InputMap.action_get_events("select")[0].as_text()
	$controles/Panel/HBoxContainer/VBoxContainer2/control_instance2/Button.text = InputMap.action_get_events("inventaire_left")[0].as_text()
	$controles/Panel/HBoxContainer/VBoxContainer2/control_instance3/Button.text = InputMap.action_get_events("inventaire_right")[0].as_text()
	$controles/Panel/HBoxContainer/VBoxContainer2/control_instance4/Button.text = InputMap.action_get_events("pause")[0].as_text()

	if GestionsEvents.current_event == "event_alter2":
		Musique.stream = Musique.musique_menu_bug
		Musique.play()
		$TextureRect.texture = preload("res://sprites/title_screen2.png")
		var grad = GradientTexture1D.new()
		grad.gradient = Gradient.new()
		grad.gradient.set_color(0, Color.BLUE)
		grad.gradient.set_color(1, Color.BLUE)
		$fond.texture = grad
		
		
func _on_options_pressed() -> void:
	$menu.visible = false
	$options.visible = true


func _on_option_button_item_selected(index: int) -> void:
	match index:
		# Faible
		0:
			get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
		# Elevée
		1:
			get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS


func _input(event: InputEvent) -> void:
	if wait_input and (event is InputEventKey or event is InputEventMouseButton or event is InputEventJoypadButton or event is InputEventJoypadMotion):
		var text_event = event.as_text()
		InputMap.action_erase_events(wait_input_action_name)
		InputMap.action_add_event(wait_input_action_name, event)
		for node in get_tree().get_nodes_in_group("boutons_controles"):
			if node.button_pressed:
				node.button_pressed = false
				node.text = text_event
			if node.disabled:
				node.disabled = false

func _on_musique_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Musique"), value/100.)


func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), value/100.)


func _on_button_controles_pressed() -> void:
	$options.visible = false
	$controles.visible = true
	$TextureRect.visible = false

func _on_button_retour_options_pressed() -> void:
	$menu.visible = true
	$options.visible = false

func _on_button_up_toggled(toggled_on: bool) -> void:
	if toggled_on:
		for node in get_tree().get_nodes_in_group("boutons_controles"):
			node.disabled = true
		wait_input = true
		wait_input_action_name = "up"


func _on_button_down_toggled(toggled_on: bool) -> void:
	if toggled_on:
		for node in get_tree().get_nodes_in_group("boutons_controles"):
			node.disabled = true
		wait_input = true
		wait_input_action_name = "down"


func _on_button_left_toggled(toggled_on: bool) -> void:
	if toggled_on:
		for node in get_tree().get_nodes_in_group("boutons_controles"):
			node.disabled = true
		wait_input = true
		wait_input_action_name = "left"


func _on_button_right_toggled(toggled_on: bool) -> void:
	if toggled_on:
		for node in get_tree().get_nodes_in_group("boutons_controles"):
			node.disabled = true
		wait_input = true
		wait_input_action_name = "right"


func _on_button_run_toggled(toggled_on: bool) -> void:
	if toggled_on:
		for node in get_tree().get_nodes_in_group("boutons_controles"):
			node.disabled = true
		wait_input = true
		wait_input_action_name = "run"


func _on_button_interagir_toggled(toggled_on: bool) -> void:
	if toggled_on:
		for node in get_tree().get_nodes_in_group("boutons_controles"):
			node.disabled = true
		wait_input = true
		wait_input_action_name = "interagir"



func _on_button_cancel_toggled(toggled_on: bool) -> void:
	if toggled_on:
		for node in get_tree().get_nodes_in_group("boutons_controles"):
			node.disabled = true
		wait_input = true
		wait_input_action_name = "cancel"


func _on_button_inv1_toggled(toggled_on: bool) -> void:
	if toggled_on:
		for node in get_tree().get_nodes_in_group("boutons_controles"):
			node.disabled = true
		wait_input = true
		wait_input_action_name = "select"


func _on_button_inv2_toggled(toggled_on: bool) -> void:
	if toggled_on:
		for node in get_tree().get_nodes_in_group("boutons_controles"):
			node.disabled = true
		wait_input = true
		wait_input_action_name = "inventaire_left"


func _on_button_inv3_toggled(toggled_on: bool) -> void:
	if toggled_on:
		for node in get_tree().get_nodes_in_group("boutons_controles"):
			node.disabled = true
		wait_input = true
		wait_input_action_name = "inventaire_right"


func _on_button_pause_toggled(toggled_on: bool) -> void:
	if toggled_on:
		for node in get_tree().get_nodes_in_group("boutons_controles"):
			node.disabled = true
		wait_input = true
		wait_input_action_name = "pause"

func _on_retour_controles_pressed() -> void:
	$TextureRect.visible = true
	$options.visible = true
	$controles.visible = false


func _on_quitter_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
