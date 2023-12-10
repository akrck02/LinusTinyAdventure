extends Control
class_name SoundOptionsUI

@onready var music_slider : Slider = $MusicSlider
@onready var effects_slider : Slider = $EffectsSlider

@onready var music_percent : RichTextLabel = $MusicPercent
@onready var effect_percent : RichTextLabel = $EffectPercent
@onready var return_button : Button = $ReturnButton

signal hide_requested

# Called when the node enters the scene tree for the first time.
func _ready():
	music_slider.value_changed.connect(change_music_percent);
	effects_slider.value_changed.connect(change_effect_percent);
	return_button.button_down.connect(hide_now)
	
	var music_volume = OptionsManager.get_music_volume()* 100;
	var effects_volume = OptionsManager.get_effects_volume()* 100;
	
	music_slider.value = music_volume;
	effects_slider.value = effects_volume;
	
	change_music_percent(music_volume)
	change_effect_percent(effects_volume)

func change_music_percent(value : float):
	music_percent.text = String("%d" % value)
	SignalDatabase.music_volume_changed.emit(value/100)
	

func change_effect_percent(value : float):
	effect_percent.text = String("%d" % value)
	SignalDatabase.effects_volume_changed.emit(value/100)

func show_now():
	music_slider.grab_focus();

func hide_now():
	hide_requested.emit();
