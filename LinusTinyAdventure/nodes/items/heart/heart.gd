extends Node2D

@onready var animator : AnimationPlayer = $AnimationPlayer
@export var next_level : int = 0

func _ready():
	animator.play("idle")
	set_next_level(LevelManager.current_level.number)
	
func _on_area_2d_body_entered(body):
	
	if body.is_in_group(Groups.PLAYER):
		SignalDatabase.level_change_requested.emit(next_level)
		

func set_next_level(level : int):
	next_level = level + 1
