extends CharacterBody2D

@onready var animator : AnimationPlayer = $AnimationPlayer
@onready var openSound : AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	animator.play("idle")
	
func play_open_sound():
	openSound.play()

func defeat():
	play_open_sound()
	await openSound.finished
