extends Control
class_name GraphicOptionsUI

signal hide_requested

@onready var no_effect_button : Button = $Buttons/NoEffectButton
@onready var scanlines_effect_button : Button = $Buttons/ScanlinesEffectButton
@onready var grainy_effect_button : Button = $Buttons/GrainyEffectButton
@onready var grayscale_effect_button : Button = $Buttons/GrayscaleEffectButton
@onready var midnight_effect_button : Button = $Buttons/MidnightEffectButton
@onready var cozy_effect_button : Button = $Buttons/CozyEffectButton
@onready var exit_button : Button = $Buttons/ExitButton

func _ready():
	no_effect_button.pressed.connect(set_no_effect)
	scanlines_effect_button.pressed.connect(set_scanlines_effect)
	grainy_effect_button.pressed.connect(set_grainy_effect)
	grayscale_effect_button.pressed.connect(set_grayscale_effect)
	midnight_effect_button.pressed.connect(set_midnight_effect)
	cozy_effect_button.pressed.connect(set_cozy_effect)
	exit_button.pressed.connect(hide_now)

func show_now():
	no_effect_button.grab_focus()

func hide_now():
	hide_requested.emit();
	
func set_no_effect():
	SignalDatabase.ui_camera_filter_changed.emit(CameraEffects.NONE)

func set_scanlines_effect():
	SignalDatabase.ui_camera_filter_changed.emit(CameraEffects.SCANLINES)

func set_grainy_effect():
	SignalDatabase.ui_camera_filter_changed.emit(CameraEffects.GRAINY)

func set_grayscale_effect():
	SignalDatabase.ui_camera_filter_changed.emit(CameraEffects.GRAYSCALE)

func set_midnight_effect():
	SignalDatabase.ui_camera_filter_changed.emit(CameraEffects.MIDNIGHT)

func set_cozy_effect():
	SignalDatabase.ui_camera_filter_changed.emit(CameraEffects.COZY)

