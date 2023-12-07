extends Node2D

@onready var animation = $AnimationPlayer
@onready var sound = $AudioStreamPlayer2D
@export var currentSong : AudioStreamMP3;



# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("idle");
	sound.stream = currentSong
	sound.play();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
