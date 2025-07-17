extends Resource
class_name Quete

enum Quete_State {INACTIF, EN_COURS, FINI}

@export var titre_quete : String
@export_multiline var desc_quete : String
@export var state : Quete_State

func lancer_quete() -> void:
	state = Quete_State.EN_COURS

func terminer_quete() -> void:
	state = Quete_State.FINI
