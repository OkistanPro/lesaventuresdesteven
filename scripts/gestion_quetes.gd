extends Node

var liste_quetes : Dictionary = {
	
}

func _ready() -> void:
	var directories_to_look_at = ["res://quetes/"]
	while directories_to_look_at:
		var dir = DirAccess.open(directories_to_look_at[0])
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			while file_name != "":
				if dir.current_is_dir():
					print("Found directory: " + file_name)
					directories_to_look_at.append(directories_to_look_at[0] + file_name)
				else:
					print("Found file: " + file_name)
					liste_quetes[file_name] = load(directories_to_look_at[0] + "/" + file_name)
				file_name = dir.get_next()
		else:
			print(directories_to_look_at[0])
			print("An error occurred when trying to access the path.")
		directories_to_look_at.pop_front()

func lancer_quete(nom_quete : String):
	liste_quetes[nom_quete].lancer_quete()
	interface.start_quete(liste_quetes[nom_quete].titre_quete)

func end_quete(nom_quete : String):
	liste_quetes[nom_quete].terminer_quete()
	interface.end_quete(liste_quetes[nom_quete].titre_quete)
