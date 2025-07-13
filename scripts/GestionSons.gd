extends AudioStreamPlayer

var playback : AudioStreamPlaybackPolyphonic
var sounds = {
	"collect_item" : [
		preload("res://sons/collect_item_sparkle_pop_09.wav"),
		-15.0
	]
}


func _ready() -> void:
	stream = AudioStreamPolyphonic.new()
	play()
	playback = get_stream_playback()
	
func play_sound(name_sound : String):
	playback.play_stream(sounds[name_sound][0], 0, sounds[name_sound][1])
