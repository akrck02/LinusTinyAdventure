extends Node2D

@onready var PuzzleButtonOne : PuzzleButton = $Button
@onready var Buttons = [$Button,$Button2]
@onready var Key = $Key

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalDatabase.button_pressed.connect(button_click)

# On button click
func button_click(_button : PuzzleButton, action_starter : Node2D):
	
	if action_starter.is_in_group(Groups.BOX):
		action_starter.block()
		
		if isButtonPuzzleComplete():
			Key.show()

# Get if button puzzle is complete
func isButtonPuzzleComplete():
	for button in Buttons:
		if !button.active: 
			return false
	return true
