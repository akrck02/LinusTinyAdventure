extends CanvasLayer
class_name  OptionsUI

var Buttons = []

enum OPTION_BUTTONS {
	LEVELS = 0,
	CONTROLS = 1,
	GRAPHICS = 2,
	SOUND = 3
}

@onready var levels_button : Button = $MainOptions/ButtonBar/Levels
@onready var controls_button : Button = $MainOptions/ButtonBar/Controls
@onready var graphics_button : Button = $MainOptions/ButtonBar/Graphics
@onready var sound_button : Button = $MainOptions/ButtonBar/Sound
@onready var exit_button : Button = $MainOptions/ExitButton

@onready var main_options = $MainOptions
@onready var sound_options : SoundOptionsUI = $SoundOptions 
@onready var control_options : ControlsOptionsUI = $ControlsOptions

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	SignalDatabase.ui_show_settings.connect(show_self)
	exit_button.button_down.connect(hide_all)
	sound_options.hide.connect(show_main);
	control_options.hide.connect(show_main);
	
	Buttons = []
	
	Buttons.insert(OPTION_BUTTONS.LEVELS, levels_button)
	Buttons.insert(OPTION_BUTTONS.CONTROLS, controls_button)
	Buttons.insert(OPTION_BUTTONS.GRAPHICS, graphics_button)
	Buttons.insert(OPTION_BUTTONS.SOUND, sound_button)
	set_buttons();

func show_self(is_showing:bool = true):
	
	if is_showing:
		SignalDatabase.world_stopped.emit()
		self.show()
		Buttons[0].grab_focus()
		return
	
	hide()
	SignalDatabase.world_restarted.emit()
	
	
func set_buttons():

	for button in Buttons:
		var label = button.get_node("RichTextLabel")
		var sprite = button.get_node("Sprite2D")
		label.text = "[center]" + button.name
		sprite.texture = load(Constants.UI_SPRITE_PATH + button.name.to_lower() + ".png")
		sprite.set_scale(Vector2(.5,.5))
		
	Buttons[OPTION_BUTTONS.LEVELS].pressed.connect(on_level_click)
	Buttons[OPTION_BUTTONS.SOUND].pressed.connect(on_sound_click)
	Buttons[OPTION_BUTTONS.CONTROLS].pressed.connect(on_controls_click)
	
func on_level_click():
	SignalDatabase.scene_change_requested.emit(Constants.SELECTOR_SCENE_PATH)
	
func on_sound_click():
	hide_main();
	SoundOptions.show()
	SoundOptions.showNow()

func on_controls_click():
	hide_main();
	ControlOptions.show()
	ControlOptions.showNow()

func show_main():
	MainOptions.show()
	Buttons[0].grab_focus()

func hide_main():
	MainOptions.hide()

func hide_all():
	show_self(false)
