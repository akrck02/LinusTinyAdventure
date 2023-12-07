class_name Key
extends CharacterBody2D

@onready var animator : AnimationPlayer = $AnimationPlayer
@onready var movement = $Movement
var consumable = true
var defeat_groups = [Groups.DOOR]

func _ready():
	animator.play("idle")

func move(dir : Vector2): 
	return await movement.move(dir)

func block():
	movement.blocked = true

func teleport(new_position : Vector2, collider : Node2D, dir : Vector2):
	movement.teleport(new_position,collider,dir)
