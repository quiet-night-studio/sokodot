extends Node

var file_name = "save.data"
var data = {}
var file_directory = "user://"+file_name



func _ready():
	load_game()
	
func save_game():
	var file = File.new()
	file.open(file_directory, file.WRITE)
	file.store_var(data)
	file.close()

func load_game():
	var file = File.new()
	if file.file_exists(file_directory):
		file.open(file_directory, file.READ)
		data = file.get_var()
		file.close()
	else:
		data = {
			"moves": 420,
			"current_level": {},
			"objects": {}
		}
	return data

