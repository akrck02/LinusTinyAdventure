extends Node2D

@onready var animation = $AnimationPlayer
@onready var sound = $AudioStreamPlayer2D
@export var current_song : AudioStreamMP3;

const IDLE_ANIMATION_NAME = "idle"

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play(IDLE_ANIMATION_NAME);
	sound.stream = current_song
	sound.play();
