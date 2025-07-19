extends AudioStreamPlayer

var playback : AudioStreamPlaybackPolyphonic
var sounds = {
	"collect_item" : [
		preload("res://sons/collect_item_sparkle_pop_09.wav"),
		-15.0
	],
	"no_timeline" : [
		preload("res://sons/ui_menu_button_error_01.wav"),
		-15.0
	],
	"ding_epicerie" : [
		preload("res://sons/494565__775noise__shop-door-bell.wav"),
		-15.0
	],
	"balai" : [
		preload("res://sons/broom.wav"),
		-5.0
	]
}


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	stream = AudioStreamPolyphonic.new()
	play()
	playback = get_stream_playback()
	
func play_sound(name_sound : String):
	playback.play_stream(sounds[name_sound][0], 0, sounds[name_sound][1])
