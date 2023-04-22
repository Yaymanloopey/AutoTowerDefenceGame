extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var game_dir = ""

# Called when the node enters the scene tree for the first time.
func save_score(score: int) -> void:
	var file = File.new()
	var path = str(game_dir)+"game_save.sav"  # Use the user:// prefix to save the file in the user data folder
	file.open(path, File.WRITE)
	file.store_line(str(score))
	file.close()

func load_score() -> int:
	var file = File.new()
	var path = "game_save.sav"  # Use the user:// prefix to load the file from the user data folder
	if file.file_exists(path):
		file.open(path, File.READ)
		var score = int(file.get_line())
		file.close()
		return score
	else:
		return 0

