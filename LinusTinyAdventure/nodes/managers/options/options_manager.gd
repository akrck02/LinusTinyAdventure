extends Node2D

const OPTIONS_FILENAME = "user://lta.options.json";
var current_options :  Dictionary;

func _ready():
	SignalDatabase.music_volume_changed.connect(change_music_volume)
	SignalDatabase.effects_volume_changed.connect(change_effects_volume)
	
	load_options()

func load_options() -> Dictionary:
	
	if not FileAccess.file_exists(OPTIONS_FILENAME):
		current_options = default_options();
		save_options()
		return current_options;

	var save_game_file = FileAccess.open(OPTIONS_FILENAME, FileAccess.READ).get_as_text()

	var json : JSON = JSON.new()
	var result = json.parse(save_game_file)
	
	if result == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_DICTIONARY:
			current_options = data_received
			return data_received
		
	else:
		## Load error scene
		print("JSON Parse Error: ", json.get_error_message(), " in ", save_game_file, " at line ", json.get_error_line())
		EngineUtils.load_scene(self,Constants.ERROR_SCENE_NAME)
	
	return current_options;


func save_options() -> void :
	var save_game_file = FileAccess.open(OPTIONS_FILENAME, FileAccess.WRITE)
	
	save_game_file.store_line(JSON.stringify(current_options))
	save_game_file.close()


func default_options() -> Dictionary :
	return {
		"general": {
			"vibration" : "true"
		},
		"graphics":{},
		"audio" : {
			"music" : "100",
			"effects" : "100"
		}	
	}

func is_vibration_enabled() -> bool:
	return true if current_options.get("general").get("vibration") == "true" else false


func toggle_vibration():
	current_options.get("general")["vibration"] = str(not is_vibration_enabled());
	save_options()


func get_camera_filter() ->String :
	return current_options.get("graphics")["camera_effect"];


func set_camera_filter(filter : String):
	current_options.get("graphics")["camera_effect"] = filter;
	save_options()

func getMusicVolume() -> float:
	return float(current_options.get("audio")["music"])

func change_music_volume(value : float):
	var busId = AudioServer.get_bus_index(Constants.AUDIO_MUSIC_BUS);
	var isUpdate = float(current_options.get("audio")["music"]) != value;
	
	current_options.get("audio")["music"] = value;
	value = linear_to_db(value)
	AudioServer.set_bus_volume_db(busId,value)
	
	if isUpdate:
		save_options()

func getEffectsVolume() -> float:
	return float(current_options.get("audio")["effects"])
	
func change_effects_volume(value : float): 
	
	var busId = AudioServer.get_bus_index(Constants.AUDIO_EFFECTS_BUS);
	var isUpdate = float(current_options.get("audio")["effects"]) != value;
	
	current_options.get("audio")["effects"] = value;
	value = linear_to_db(value)
	AudioServer.set_bus_volume_db(busId,value)
	
	if isUpdate:
		save_options()

