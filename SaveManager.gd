extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var game_dir = ""

func _ready():
	pass
	
# Called when the node enters the scene tree for the first time.
func save_result(column_name: String, new_value: float) -> void:
	if column_name == "ATTACK_SPEED":
		print(column_name)
		print(new_value)
	var file = File.new()
	var path = str(game_dir)+"game_save.sav"  # Use the user:// prefix to save the file in the user data folder
	var data_dict = {"POINTS": "0", "SCORE": "0", "ATTACK_SPEED": "1.5", "ATTACK_SPEED_COST": "10", "ATTACK_POWER": "1","ATTACK_POWER_COST": "10", "HEALTH": "3", "HEALTH_COST": "10", "ENEMY_HEALTH": "2", "ENEMY_HEALTH_COST": "20"}
#	var data_dict = {}
	if file.file_exists(path):
		file.open(path, File.READ)
		# BELOW LINE GETS THE TEXT AS A JSON RESULT, WHICH NEEDS TO BE PARSED AGAIN
		var file_text = JSON.parse(file.get_as_text())
		# BELOW LINE PARSES THE RESULTS OF THE ABOVE JSON EXTRACT
		data_dict = file_text.result
		file.close()
	data_dict[column_name.to_upper()] = str(new_value)
	file.open(path, File.WRITE)
	file.store_line(JSON.print(data_dict))
	file.close()

func load_result(column_name: String) -> String:
	var file = File.new()
	var path = str(game_dir)+"game_save.sav"  # Use the user:// prefix to load the file from the user data folder
	if file.file_exists(path):
		file.open(path, File.READ)
		# BELOW LINE GETS THE TEXT AS A JSON RESULT, WHICH NEEDS TO BE PARSED AGAIN
		var file_text = JSON.parse(file.get_as_text())
		# BELOW LINE PARSES THE RESULTS OF THE ABOVE JSON EXTRACT
		var data_dict = file_text.result
		file.close()
		if column_name.to_upper() in data_dict:
			return str(data_dict[column_name.to_upper()])
		else:
			print(str(column_name) + "column name doesn't exist")
			var default_value = load_defaults(column_name)
			return default_value
	else:
		print("File Doesn't Exist")
		var default_value = load_defaults(column_name)
		return default_value

func load_defaults(column_name) -> int:
	var default_value = 0
	if column_name.to_upper() == "ATTACK_SPEED":
		default_value = 1.5
	elif column_name.to_upper() == "ATTACK_SPEED_COST" || column_name.to_upper() == "ATTACK_POWER_COST" || column_name.to_upper() == "HEALTH_COST":
		default_value = 10
	elif column_name.to_upper() == "ENEMY_HEALTH_COST":
		default_value = 20
	elif column_name.to_upper() == "SCORE":
		default_value = 0
	elif column_name.to_upper() == "ATTACK_POWER":
		default_value = 1
	elif column_name.to_upper() == "ENEMY_HEALTH":
		default_value = 2
	elif column_name.to_upper() == "HEALTH":
		default_value = 2
	else:
		default_value = 0
	
		print(column_name)
		print(default_value)
	return default_value
