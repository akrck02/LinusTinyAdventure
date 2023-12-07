class_name LevelButton
extends Button

const LEVEL_NUMBER_METADATA = "level_number"
const LEVEL_TEMPLATE = "levels/{number}-{name}.tscn"

@export var blocked = true
@onready var blockNode : Node2D = $Block
@onready var lockNode : Node2D = $Block/Lock

func _on_focus_entered():
	Input.start_joy_vibration(0,.1,0.2,0.25)
	SignalDatabase.button_level_focus.emit(self)
	
func _on_pressed():
	var level_number = get_meta(LEVEL_NUMBER_METADATA)
	SignalDatabase.level_change_requested.emit(level_number)

func unblock():
	
	if blockNode == null:
		return;
	
	blocked = false
	disabled = false
	blockNode.hide()

func block():
	
	if blockNode == null:
		return;
	
	blocked = true
	disabled = true
	blockNode.show()

func rotate(degrees : int):
	rotation_degrees = degrees
