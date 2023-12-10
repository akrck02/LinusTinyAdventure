extends Control
class_name ControlsOptionsUI

signal hide_requested

@onready var gamepad_controls = $Gamepad
@onready var keyboard_controls = $Keyboard
@onready var exit_button = $ExitButton

var gamepad;

func show_now():
	exit_button.pressed.connect(exit)
	exit_button.grab_focus()

func hide_now():
	hide_requested.emit();
	
func _ready():
	exit_button.grab_focus()

func _process(_delta):
	
	if Input.get_joy_name(0) != gamepad:
		set_input_icons()
			

func set_input_icons():
	gamepad = Input.get_joy_name(0)
		
	if gamepad == "":
		gamepad_controls.hide()
		keyboard_controls.show()
	else: 
		keyboard_controls.hide()
		gamepad_controls.show()


func exit():
	hide_now()

