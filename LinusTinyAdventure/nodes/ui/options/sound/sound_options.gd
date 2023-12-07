extends Control
class_name SoundOptionsUI

@onready var MusicSlider : Slider = $MusicSlider
@onready var EffectsSlider : Slider = $EffectsSlider

@onready var MusicPercent : RichTextLabel = $MusicPercent
@onready var EffectPercent : RichTextLabel = $EffectPercent
@onready var returnButton : Button = $ReturnButton

signal hide

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicSlider.value_changed.connect(changeMusicPercent);
	EffectsSlider.value_changed.connect(changeEffectPercent);
	returnButton.button_down.connect(hideNow)
	
	var musicVolume = OptionsManager.getMusicVolume()* 100;
	var effectsVolume = OptionsManager.getEffectsVolume()* 100;
	
	MusicSlider.value = musicVolume;
	EffectsSlider.value = effectsVolume;
	
	changeMusicPercent(musicVolume)
	changeEffectPercent(effectsVolume)

func changeMusicPercent(value : float):
	MusicPercent.text = String("%d" % value)
	SignalDatabase.music_volume_changed.emit(value/100)
	

func changeEffectPercent(value : float):
	EffectPercent.text = String("%d" % value)
	SignalDatabase.effects_volume_changed.emit(value/100)

func showNow():
	MusicSlider.grab_focus();

func hideNow():
	hide.emit();
