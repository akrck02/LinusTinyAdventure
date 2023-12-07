class_name Player
extends CharacterBody2D

# UI 
@onready var Animator : AnimationPlayer = $AnimationPlayer
@onready var Sprite : Sprite2D = $Sprite2D
const TILE_SIZE = 16

# Interaction
@onready var ray : RayCast2D = $RayCast2D
@onready var tween : Tween
var moving = false

# step count
var steps = 0;

func _ready():
	Animator.play("idle")

# Input handleawait tween.finished
func _process(_delta):
	
	if Input.is_action_just_pressed(Controls.START):
		SignalDatabase.world_stopped.emit()
		SignalDatabase.ui_show_settings.emit()
		
	if Input.is_action_just_pressed(Controls.RESET_LEVEL):
		LevelManager.reset_level()
		return
		
	if moving:
		return
	
	# Right movement
	if Input.is_action_pressed(Controls.RIGHT):
		await move(Vector2.RIGHT)
		
	# Left movement
	elif Input.is_action_pressed(Controls.LEFT):
		await move(Vector2.LEFT)
		
	# Up movement
	elif Input.is_action_pressed(Controls.UP):
		await move(Vector2.UP)
		
	# Down movement
	elif Input.is_action_pressed(Controls.DOWN):
		await move(Vector2.DOWN)

# Move the player 
func move(dir):
	
	moving = true
	var new_position = dir * TILE_SIZE
	ray.target_position = new_position
	ray.force_raycast_update()
		
	if ray.is_colliding():
		
		var collider = ray.get_collider()
		if collider.is_in_group(Groups.MOVABLE) and await collider.move(dir):
			step()
			tween = create_tween()
			tween.tween_property(self,"position",position + new_position, 1.00/3.5).set_trans(Tween.TRANS_SINE)
			Input.start_joy_vibration(0,.1,0.2,0.25)
			
			if collider.has_method("playMoveSound"):
				collider.playMoveSound();
			
			await tween.finished
			tween.kill()
	else: 
		step()
		tween = create_tween()
		tween.tween_property(self,"position",position + new_position, 1.00/3.5).set_trans(Tween.TRANS_SINE)
		await tween.finished
		tween.kill()
		
	moving = false

# Add one to step counter
func step():
	steps += 1
	SignalDatabase.player_step.emit(steps);

# Teleport the player
func teleport(new_position : Vector2, collider : Node2D, dir : Vector2):
	
	await tween.finished
	
	if collider == null:
		position = new_position
		return
	
	if collider.is_in_group(Groups.MOVABLE) and await collider.move(dir):
		step()
		Input.start_joy_vibration(0,.1,0.2,0.25)
		position = new_position
		return
	
	
