extends Node

const SAVE_FILENAME = "user://linusTinyAdventure.save.json";
var current_savestate : Dictionary = {};

func _ready():
	SignalDatabase.new_game_created.connect(new_game)
	SignalDatabase.save_game_requested.connect(save_game)
	
	SaveManager.load_game()
	
	if SaveManager.current_savestate == {}:
		SaveManager.new_game()
		return

	print(SaveManager.current_savestate)

# Create a new savestate
func new_game() -> Dictionary: 
	
	var save_game_file = FileAccess.open(SAVE_FILENAME, FileAccess.WRITE)
	current_savestate = default_savestate()
	save_game_file.store_line(JSON.stringify(current_savestate))
	SignalDatabase.game_savestate_loaded.emit();
	return current_savestate

# Save the game state
func save_game():
		
	var save_game_file = FileAccess.open(SAVE_FILENAME, FileAccess.WRITE)
	current_savestate["current_level"] = LevelManager.current_level.number
	current_savestate["max_level"] = LevelManager.max_level.number
		
	save_game_file.store_line(JSON.stringify(current_savestate))
	save_game_file.close()
	

# Load the current savestate
func load_game() -> Dictionary:
	
	if not FileAccess.file_exists(SAVE_FILENAME):
		return {};

	var save_game_file = FileAccess.open(SAVE_FILENAME, FileAccess.READ).get_as_text()

	var json : JSON = JSON.new()
	var result = json.parse(save_game_file)
	
	if result == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_DICTIONARY:
			current_savestate = data_received
			SignalDatabase.game_savestate_loaded.emit();
			return data_received
		
	else:
		## Load error scene
		print("JSON Parse Error: ", json.get_error_message(), " in ", save_game_file, " at line ", json.get_error_line())
		SignalDatabase.scene_change_requested.emit(Constants.ERROR)
	
	return {}


# Default savestate of the game
func default_savestate() -> Dictionary: 
	return {
		"current_level" : 1,
		"max_level" : 1
	}
