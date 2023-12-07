extends CanvasLayer
class_name  OptionsUI

var Buttons = []

enum OPTION_BUTTONS {
	LEVELS = 0,
	CONTROLS = 1,
	GRAPHICS = 2,
	SOUND = 3
}

@onready var LevelsButton : Button = $MainOptions/ButtonBar/Levels
@onready var ControlsButton : Button = $MainOptions/ButtonBar/Controls
@onready var GraphicsButton : Button = $MainOptions/ButtonBar/Graphics
@onready var SoundButton : Button = $MainOptions/ButtonBar/Sound
@onready var ExitButton : Button = $MainOptions/ExitButton

@onready var MainOptions = $MainOptions
@onready var SoundOptions : SoundOptionsUI = $SoundOptions 
@onready var ControlOptions : ControlsOptionsUI = $ControlsOptions

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	SignalDatabase.ui_show_settings.connect(show_self)
	ExitButton.button_down.connect(hide_all)
	SoundOptions.hide.connect(show_main);
	ControlOptions.hide.connect(show_main);
	
	Buttons = []
	
	Buttons.insert(OPTION_BUTTONS.LEVELS, LevelsButton)
	Buttons.insert(OPTION_BUTTONS.CONTROLS, ControlsButton)
	Buttons.insert(OPTION_BUTTONS.GRAPHICS, GraphicsButton)
	Buttons.insert(OPTION_BUTTONS.SOUND, SoundButton)
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
