class_name Player
extends CharacterBody2D

# UI 
@onready var Sprite : Sprite2D = $Sprite2D

# Interaction
@onready var ray : RayCast2D = $RayCast2D
@onready var tween : Tween
var moving = false

# Sounds
@onready var sounds : PlayerSounds = $Sounds

# Step count
var steps = 0;

# Movement
const PLAY_MOVE_SOUND_METHOD_NAME : String = "play_move_sound" 
const MOVEMENT_TWEEN_SPEED : float = 1.00/3.5;


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
	var new_position = dir * Constants.TILE_SIZE
	ray.target_position = new_position
	ray.force_raycast_update()
		
	if ray.is_colliding():
		
		var collider = ray.get_collider()
		if collider.is_in_group(Groups.MOVABLE) and await collider.move(dir):
			step()
			tween = create_tween()
			tween.tween_property(self, NodeExtensor.POSITION_PROPERTIES,position + new_position, MOVEMENT_TWEEN_SPEED).set_trans(Tween.TRANS_SINE)
			VibrationManager.vibrate()
			
			if collider.has_method(PLAY_MOVE_SOUND_METHOD_NAME):
				collider.play_move_sound();
			
			await tween.finished
			tween.kill()
	else: 
		step()
		tween = create_tween()
		tween.tween_property(self, NodeExtensor.POSITION_PROPERTIES, position + new_position, MOVEMENT_TWEEN_SPEED).set_trans(Tween.TRANS_SINE)
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
		sounds.teleport_sound_play_requested.emit()
		position = new_position
		return
	
	if collider.is_in_group(Groups.MOVABLE) and await collider.move(dir):
		step()
		sounds.teleport_sound_play_requested.emit()
		VibrationManager.vibrate()
		position = new_position
		return
	
	sounds.block_sound_play_requested.emit()
	VibrationManager.vibrate()
	SignalDatabase.camera_shake.emit()
