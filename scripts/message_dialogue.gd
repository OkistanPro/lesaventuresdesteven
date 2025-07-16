extends Label

signal message_ended

var is_writing : bool = false
var message_buffer : String
var i : int = 0
var speed : float = 1.0

func begin_message(message : String) -> void:
	is_writing = true
	speed = 1.0
	text = ""
	message_buffer = message
	i = 0
	while i < len(message_buffer):
		await show_char()
	message_ended.emit()
	is_writing = false

func show_char() -> void:
	if speed == 1.0:
		$son_message.volume_db = randi_range(-4, 0)
		$son_message.play()
	var c = message_buffer[i]
	text += c
	match c:
		" ":
			await get_tree().create_timer(0.03*speed).timeout
		".":
			await get_tree().create_timer(0.08*speed).timeout
		_:
			await get_tree().create_timer(0.02*speed).timeout
	i += 1
	return
