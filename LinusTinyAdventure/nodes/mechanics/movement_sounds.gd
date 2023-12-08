extends Node2D
class_name MovementSounds

@onready var block_sound : AudioStreamPlayer2D = $BlockSound
@onready var teleport_sound : AudioStreamPlayer2D = $TeleportSound

var teleport_sound_playing : bool = false;
var block_sound_playing : bool = false;

signal teleport_sound_play_requested
signal block_sound_play_requested

# Called when the node enters the scene tree for the first time.
func _ready():
	block_sound_play_requested.connect(play_block_sound)
	teleport_sound_play_requested.connect(play_teleport_sound)


func play_block_sound():
	
	if block_sound_playing: 
		return
	
	block_sound_playing = true
	block_sound.play()
	await block_sound.finished
	block_sound_playing = false

func play_teleport_sound():

	if teleport_sound_playing: 
		return
	
	teleport_sound_playing = true
	teleport_sound.play()
	await teleport_sound.finished
	teleport_sound_playing = false
