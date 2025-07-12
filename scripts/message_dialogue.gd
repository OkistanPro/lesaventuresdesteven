extends Label

signal message_ended

var message_buffer : String
var i : int = 0

func begin_message(message : String) -> void:
	text = ""
	message_buffer = message
	i = 0
	while i < len(message_buffer):
		await show_char()
	message_ended.emit()

func show_char() -> void:
	var c = message_buffer[i]
	text += c
	match c:
		" ":
			await get_tree().create_timer(0.05).timeout
		".":
			await get_tree().create_timer(0.1).timeout
		_:
			await get_tree().create_timer(0.04).timeout
	i += 1
	return
