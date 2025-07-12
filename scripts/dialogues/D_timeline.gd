extends Resource
class_name D_Timeline

@export var liste_messages : Array[D_Object]
var current_message : int = 0

func get_message() -> D_Object:
	var obj
	if current_message < len(liste_messages):
		obj = liste_messages[current_message]
	else:
		obj = null
	current_message += 1
	return obj
