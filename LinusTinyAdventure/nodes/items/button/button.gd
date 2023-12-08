class_name PuzzleButton
extends Node2D

const DEFAULT_COLOR : String = "6cbcf6"
const DISABLE_COLOR : String = "818181"

@onready var animator : AnimationPlayer = $AnimationPlayer
@onready var button_clicker_sprite : Sprite2D = $ButtonClickerSprite
@export var color = DEFAULT_COLOR
var active = false;
var enabled = true;

func _ready():
	animator.play("idle")
	button_clicker_sprite.modulate = color

func _on_area_2d_body_entered(body):
	
	if not enabled:
		return
		
	active = true;
	SignalDatabase.button_pressed.emit(self, body)

func _on_area_2d_body_exited(_body):
	
	if not enabled:
		return
		
	active = false;

func disable_button():
	button_clicker_sprite.modulate = DISABLE_COLOR
	animator.play("RESET")
	enabled = false;
