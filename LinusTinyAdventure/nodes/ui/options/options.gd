extends CanvasLayer
class_name  OptionsUI

var buttons = []

@onready var levels_button : Button = $MainOptions/ButtonBar/Levels
@onready var controls_button : Button = $MainOptions/ButtonBar/Controls
@onready var graphics_button : Button = $MainOptions/ButtonBar/Graphics
@onready var sound_button : Button = $MainOptions/ButtonBar/Sound
@onready var exit_button : Button = $MainOptions/ExitButton

@onready var main_options = $MainOptions
@onready var sound_options : SoundOptionsUI = $SoundOptions 
@onready var control_options : ControlsOptionsUI = $ControlsOptions
@onready var graphic_options : GraphicOptionsUI = $GraphicOptions

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	SignalDatabase.ui_show_settings.connect(show_self)
	exit_button.button_down.connect(hide_all)
	sound_options.hide_requested.connect(show_main);
	control_options.hide_requested.connect(show_main);
	graphic_options.hide_requested.connect(show_main)

	levels_button.pressed.connect(on_level_click)
	sound_button.pressed.connect(on_sound_click)
	controls_button.pressed.connect(on_controls_click)
	graphics_button.pressed.connect(on_graphic_click)

func show_self(is_showing:bool = true):
	
	if is_showing:
		SignalDatabase.world_stopped.emit()
		self.show()
		levels_button.grab_focus()
		return
	
	hide()
	SignalDatabase.world_restarted.emit()
	
func on_level_click():
	print("asdas")
	SignalDatabase.scene_change_requested.emit(Constants.SELECTOR_SCENE_PATH)
	
func on_sound_click():
	hide_main();
	sound_options.show()
	sound_options.show_now()

func on_controls_click():
	hide_main();
	control_options.show()
	control_options.show_now()

func on_graphic_click():
	hide_main()
	graphic_options.show()
	graphic_options.show_now()

func show_main():
	sound_options.hide()
	control_options.hide()
	graphic_options.hide()
	main_options.show()
	levels_button.grab_focus()

func hide_main():
	main_options.hide()

func hide_all():
	show_self(false)
