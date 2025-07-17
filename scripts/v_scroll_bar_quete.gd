extends VScrollBar


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $"../VBoxContainer".size.y <= 300:
		visible = false
	else:
		visible = true
		max_value = $"../VBoxContainer".size.y - 300 + 50

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("scroll_down") and visible:
		value += 5
		_on_scrolling()
	if event.is_action_pressed("scroll_up") and visible:
		value -= 5
		_on_scrolling()

func _on_scrolling() -> void:
	$"../VBoxContainer".position.y = -value
