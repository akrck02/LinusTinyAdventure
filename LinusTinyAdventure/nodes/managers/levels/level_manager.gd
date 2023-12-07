extends Node

const LIST_LEVELS_ERROR = "An error occurred when trying to access the path."
const UP_ROTATION_DEGREES = 0
const LEFT_ROTATION_DEGREES = 90
const DOWN_ROTATION_DEGREES = 180
const RIGHT_ROTATION_DEGREES = 270

const TELEPORT_METHOD_NAME = "teleport"
const LEVEL_TEMPLATE = "levels/{number}-{name}.tscn"

var levels = []
var current_level : Level; 
var max_level : Level;

var loading_packed_scene : PackedScene; 


# Connect the signals to the respective functions
func _ready():
	levels = list_levels(Constants.LEVELS_PATH)
	
	SignalDatabase.game_savestate_loaded.connect(load_saved_data);
	SignalDatabase.scene_change_requested.connect(load_scene)
	SignalDatabase.level_change_requested.connect(change_level)
	SignalDatabase.level_changed.connect(set_current_level)
	SignalDatabase.world_stopped.connect(stop_world)
	SignalDatabase.world_restarted.connect(restart_world)
	SignalDatabase.teleport_requested.connect(teleport)
	loading_packed_scene = preload(Constants.SCENE_PATH + Constants.LOADER)

# Load saved data into level manager
func load_saved_data():
	
	var saved_current_level_number = int(SaveManager.current_savestate["current_level"]) 
	var max_current_level_number = int(SaveManager.current_savestate["max_level"]) 
	
	current_level = get_level(saved_current_level_number)
	max_level = get_level(max_current_level_number)

# Change levels
func change_level(level : int, transition : bool = true) -> bool: 
	
	var next_level : Level = get_level(level)
	
	if next_level == null:
		return false
		
	if level >= max_level.number:
		max_level = next_level
		SaveManager.save_game()
	
	var next_level_path = LEVEL_TEMPLATE.format({
		"number": next_level.number,
		"name": next_level.name
	})

	var path = Constants.SCENE_PATH + next_level_path 
	if transition == true:
		load_scene_with_transition(path)
	else: 
		load_scene(path);
	
	SignalDatabase.level_changed.emit(level)
	return true

# Stop every world item
func stop_world(): 
	var nodes = get_tree().get_nodes_in_group(Groups.WORLD)
	
	for node in nodes:
		node.set_physics_process(false)
		node.set_process(false)
		node.set_process_input(false)
		node.set_process_internal(false)

# Restart the world movement
func restart_world():
	var nodes = get_tree().get_nodes_in_group(Groups.WORLD)
	
	for node in nodes:
		node.set_physics_process(true)
		node.set_process(true)
		node.set_process_input(true)
		node.set_process_internal(true)

# Teleport a Node 
func teleport(node : Node2D, new_position : Vector2, detector : RayCast2D, direction : int = 0):
	
	# Check if something if there
	detector.rotation_degrees = UP_ROTATION_DEGREES;
	var directionVector = Vector2.ZERO

	# switch direction
	if direction == Direction.UP:
		detector.rotation_degrees = UP_ROTATION_DEGREES;
		directionVector = Vector2.UP
	
	elif direction == Direction.RIGHT:
		detector.rotation_degrees = RIGHT_ROTATION_DEGREES;
		directionVector = Vector2.LEFT
	
	elif direction == Direction.DOWN:
		detector.rotation_degrees = DOWN_ROTATION_DEGREES;
		directionVector = Vector2.DOWN
		
	elif direction == Direction.LEFT:
		detector.rotation_degrees = LEFT_ROTATION_DEGREES;
		directionVector = Vector2.RIGHT
	
	detector.force_raycast_update()
	var collider = detector.get_collider()
	
	# Teleport the object
	if !node.has_method(TELEPORT_METHOD_NAME):
		return
	
	await node.teleport(new_position, collider, directionVector)

# List all the levels in the level directory
func list_levels(path) -> Array:
	
	var levelnames = []
	var dir = DirAccess.open(path)
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			
			if dir.current_is_dir():
				continue
			
			if file_name.contains(".gd"):
				continue

			levelnames.append(file_name)
			file_name = dir.get_next()
	else:
		print(LIST_LEVELS_ERROR)

	var i = 1
	var listed_levels = []
	levelnames.sort();
	for levelname in levelnames:
		var level = Level.new()
		level.name = levelname.substr(levelname.find("-") + 1, levelname.find(".tscn") - levelname.find("-") - 1)  
		level.number = i
		listed_levels.append(level)
		i+=1


	return listed_levels

# Set current level
func set_current_level(level : int):
	current_level = get_level(level)


# Get a level from the list
func get_level(index : int) -> Level:
	
	index -= 1 
	if levels.size() <= index:
		return null 
	
	return levels[index] 

# Load scene
func load_scene_with_transition(next_scene_path : String):
	
	var canvas = get_tree().get_root().get_node("/root/Canvas")
	var current_scenes = canvas.get_children()
	for past_scene in current_scenes:
		print("%s" % past_scene)
		past_scene.queue_free()
	
	# add loading scene to the root
	var loading_scene = loading_packed_scene.instantiate()
	get_tree().get_root().call_deferred("add_child",loading_scene)
	
	# find the targeted scene
	var error = ResourceLoader.load_threaded_request(next_scene_path)
	
	#check for errors
	if error != OK:
		# handle your error 
		print("error occured while getting the scene " + next_scene_path)
		return

	var progress = [0]
	while progress[0] < 1:
		ResourceLoader.load_threaded_get_status(next_scene_path, progress)
		
	# creating a little delay, that lets the loading screen to appear.
	await get_tree().create_timer(3).timeout
	
	# adding scene to the root
	var scene = ResourceLoader.load_threaded_get(next_scene_path).instantiate()
	canvas.call_deferred("add_child",scene)
	
	# removing loading scene
	loading_scene.queue_free()

# Change scene 
func load_scene(next_scene_path : String): 
	
	if !next_scene_path.begins_with("res://"):
		next_scene_path = Constants.SCENE_PATH + next_scene_path
	
	var canvas = get_tree().get_root().get_node("/root/Canvas")
	var current_scenes = canvas.get_children()
	for past_scene in current_scenes:
		print("%s" % past_scene)
		past_scene.queue_free()
		
	# find the targeted scene
	var error = ResourceLoader.load_threaded_request(next_scene_path)
	
	#check for errors
	if error != OK:
		# handle your error 
		print("error occured while getting the scene " + next_scene_path)
		return

	var progress = [0]
	while progress[0] < 1:
		ResourceLoader.load_threaded_get_status(next_scene_path, progress)
	
	# adding scene to the root
	var scene = ResourceLoader.load_threaded_get(next_scene_path).instantiate()
	canvas.call_deferred("add_child", scene)

# Reload current scene
func reset_level():
	SignalDatabase.level_change_requested.emit(current_level.number,false)
	
