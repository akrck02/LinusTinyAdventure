class_name Teleport
extends Node2D

@export var pair : Teleport
@onready var animator : AnimationPlayer = $AnimationPlayer
@onready var detector : RayCast2D = $RayCast2D
var blocked = true

func _ready():
	animator.play("idle")

func _on_area_2d_body_entered(body):
		
	var new_position = body.position
	
	if not pair:
		return

	# Right
	if body.position.x < self.position.x: 
		new_position = Vector2(pair.position.x + Constants.TILE_SIZE, pair.position.y)
		SignalDatabase.teleport_requested.emit(body,new_position,pair.detector,Direction.LEFT)
		return
	# Left
	if body.position.x > self.position.x: 
		new_position = Vector2(pair.position.x - Constants.TILE_SIZE, pair.position.y)
		SignalDatabase.teleport_requested.emit(body,new_position,pair.detector,Direction.RIGHT)
		return
	# Up 
	if body.position.y < self.position.y:  
		new_position = Vector2(pair.position.x, pair.position.y + Constants.TILE_SIZE)
		SignalDatabase.teleport_requested.emit(body,new_position,pair.detector,Direction.DOWN)
		return
	#Down
	if body.position.y > self.position.y: 
		new_position = Vector2(pair.position.x, pair.position.y - Constants.TILE_SIZE)
		SignalDatabase.teleport_requested.emit(body,new_position,pair.detector,Direction.UP)
		return
	
