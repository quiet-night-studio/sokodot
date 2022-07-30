extends Node

const SAVE_GAME_PATH = "user://save.res"

var level_name := ""
var player_position := Vector2.ZERO

var _file := File.new()

func save_exists():
	return _file.file_exists(SAVE_GAME_PATH)

# Opens the savefile named in the variable above called "file_name", writes any data asked for, then saves on the final line.
func write_savegame():
	var error := _file.open(SAVE_GAME_PATH, File.WRITE)
	if error != OK:
		printerr("Could not open the file %s. Error: %s" % [SAVE_GAME_PATH, error])
		return
	
	var data := {
		"level_name": level_name,
		"player_position":{
			"x": player_position.x,
			"y": player_position.y
		}
	}
	
	var json_string := JSON.print(data)
	_file.store_string(json_string)
	_file.close()

func load_savegame():
	var error := _file.open(SAVE_GAME_PATH, File.READ)
	if error != OK:
		printerr("Could not open the file %s. Error: %s" % [SAVE_GAME_PATH, error])
		return
	
	var content := _file.get_as_text()
	_file.close()
	
	var data: Dictionary = JSON.parse(content).result
	player_position = Vector2(data.player_position.x, data.player_position.y)
	level_name = data.level_name
