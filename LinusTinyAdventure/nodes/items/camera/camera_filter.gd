extends CanvasLayer

@onready var filter_layer : Sprite2D = $Filter 


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalDatabase.ui_camera_filter_changed.connect(change_filter)
	change_filter(OptionsManager.get_camera_filter())

func change_filter(filter : String):
		
	if filter == null or filter == "":
		filter_layer.material = load(CameraEffects.NONE)
	
	filter_layer.material = load(filter)
