extends CharacterBody2D

@onready var animator : AnimationPlayer = $AnimationPlayer
@onready var openSound : AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	animator.play("idle")
	
func playOpenSound():
	openSound.play()

func defeat():
	playOpenSound()
