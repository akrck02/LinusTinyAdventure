extends Node2D

@onready var startLaser : Laser = $Lasers/StartLaser
@onready var endLaser : Laser = $Lasers/EndLaser
@onready var startLaserButton : PuzzleButton = $Buttons/StartLaserButton
@onready var endLaserButton : PuzzleButton = $Buttons/EndLaserButton

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalDatabase.button_pressed.connect(button_click)

# On button click
func button_click(button : PuzzleButton, _action_starter : Node2D):

	if button == startLaserButton:
		startLaser.off();
		button.disable_button()
	if button == endLaserButton:
		endLaser.off();
		button.disable_button()
