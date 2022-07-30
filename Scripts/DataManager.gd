extends Node

var file_name = "save.data"
var data = {}
var file_directory = "res://"+file_name

func _ready():
	load_game()
	
# Opens the savefile named in the variable above called "file_name", writes any data asked for, then saves on the final line.
func save_game():
	var file = File.new()
	file.open(file_directory, file.WRITE)
	file.store_var(data)
	file.close()

# Opens the savefile if it exists, loads the data, then closes the file. If data does not exist, default to the values in the else statement.
func load_game():
	var file = File.new()
	if file.file_exists(file_directory):
		file.open(file_directory, file.READ)
		data = file.get_var()
		file.close()

		return data
	else:
		return null

