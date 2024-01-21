extends Node

var fullscreen : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalDatabase.fullscreen_requested.connect(_fullscreen)


func _fullscreen():
	
	if not fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else: 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	fullscreen =! fullscreen
