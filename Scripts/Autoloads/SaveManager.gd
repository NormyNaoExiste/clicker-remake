extends Node

const FILE_PATH = "user://savefile.json"

func save(dado):
	var file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	file.store_var(dado)

func read():
	if FileAccess.file_exists(FILE_PATH):
		var file = FileAccess.open(FILE_PATH, FileAccess.READ)
		var dado = file.get_var()
		return dado
	else:
		print("sem dados")
