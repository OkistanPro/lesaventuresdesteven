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
		-15.0
	],
	"son_dingo" : [
		preload("res://sons/rire_goofy.wav"),
		-8.0
	],
	"flaque" : [
		preload("res://sons/FEETHmn_Pas dans l eau (ID 0690)_LS.wav"),
		0.0
	],
	"terre" : [
		preload("res://sons/DIRTImpt_Pelle qui creuse (ID 1305)_LS.wav"),
		-10.0
	],
	"hache" : [
		preload("res://sons/SWSH_Whoosh 4 (ID 1796)_LS.wav"),
		-5.0
	],
	"casse" : [
		preload("res://sons/large-break-363165.mp3"),
		-5.0
	],
	"porte" : [
		preload("res://sons/door_close_slam_02.wav"),
		-5.0
	],
	"ouverture_ascenceur" : [
		preload("res://sons/door_open.wav"),
		-5.0
	],
	"son_portail" : [
		preload("res://sons/metal_door_hatch_open_squeak_02.wav"),
		-5.0
	],
	"door_lock_open" : [
		preload("res://sons/door_lock_open_03.wav"),
		-5.0
	],
	"bug_fin" : [
		preload("res://sons/bug_fin.wav"),
		-5.0
	],
	"bip_crash" : [
		preload("res://sons/bip_crash.wav"),
		0.0
	],
	"glitch1" : [
		preload("res://musique/GLITCH/SFX_GLITCH2.wav"),
		0.0
	],
	"glitch2" : [
		preload("res://sons/glitch2.wav"),
		0.0
	],
	"telephone" : [
		preload("res://sons/BRUITAGE_TELEPHONE.wav"),
		0.0
	],
	"scream" : [
		preload("res://musique/GLITCH/SFX_GLITCH3.wav"),
		0.0
	],
	"toc_toc" : [
		preload("res://musique/GLITCH/SFX_GLITCH6.wav"),
		0.0
	],
	"glitch_chuchotement" : [
		preload("res://musique/GLITCH/SFX_GLITCH4.wav"),
		0.0
	],
	"poussin_dead" : [
		preload("res://sons/dead_poussin.wav"),
		0.0
	]
}


func _ready() -> void:
	bus = &"SFX"
	process_mode = Node.PROCESS_MODE_ALWAYS
	stream = AudioStreamPolyphonic.new()
	play()
	playback = get_stream_playback()
	
func play_sound(name_sound : String):
	playback.play_stream(sounds[name_sound][0], 0, sounds[name_sound][1])
