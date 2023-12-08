extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalDatabase.camera_shake.emit(Direction.LEFT)
