class_name Box
extends CharacterBody2D

@onready var animator : AnimationPlayer = $AnimationPlayer
@onready var moveSound : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var movement = $Movement

var consumable = false
var defeat_groups = []

func _ready():
	animator.play("idle")

# Check player movement
func move(dir : Vector2): 
	
	return await movement.move(dir)

# Block item movement
func block():
	movement.blocked = true

# Teleport the item 
func teleport(new_position : Vector2, collider : Node2D, dir : Vector2):
	movement.teleport(new_position,collider,dir);

func play_move_sound():
	moveSound.play()
