class_name PuzzleButton
extends Node2D

@onready var animator : AnimationPlayer = $AnimationPlayer
var active = false;

func _ready():
	animator.play("idle")

func _on_area_2d_body_entered(body):
	active = true;
	SignalDatabase.button_pressed.emit(self, body)

func _on_area_2d_body_exited(_body):
	active = false;
