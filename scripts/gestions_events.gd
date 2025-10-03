extends Node

var events_order = [
	"normal",
	"event_alter1",
	"event_alter2",
	"event_alter3"
]

var events_random = [
	"3dworld",
	"promo",
	"access_root",
	"censored"
]

var current_event : String

var launch_count : int = 0:
	set(value):
		launch_count = value
		if launch_count <= 3:
			current_event = events_order[launch_count]
		else:
			current_event = events_random[randi_range(0, len(events_random)-1)]

var config : ConfigFile = ConfigFile.new()

func _init() -> void:
	if not FileAccess.file_exists("user://config.ini"):
		config.set_value("Globals", "launch_count", 0)
		current_event = events_order[launch_count]
	else:
		config.load("user://config.ini")
		launch_count = config.get_value("Globals", "launch_count", 0)
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		config.set_value("Globals", "launch_count", launch_count)
		config.save("user://config.ini")
		if GestionsEvents.current_event != "event_alter3":
			get_tree().quit()
