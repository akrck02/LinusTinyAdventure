extends Node2D
class_name Movement

@onready var parent = get_parent()
@onready var ray : RayCast2D = $RayCast2D
@onready var sounds : MovementSounds = $Sounds

@export var moving : bool = false
@export var blocked : bool = false
@export_range(0,10) var speed : int = 4;

var tween : Tween

# Teleport the item 
func teleport(new_position : Vector2, collider : Node2D, _dir : Vector2):
		
	if collider != null: 
		sounds.block_sound_play_requested.emit()
		SignalDatabase.camera_shake.emit()
		return
		
	await tween.finished
	parent.position = new_position
	sounds.teleport_sound_play_requested.emit()

# Move thw item
func move(dir : Vector2): 

	if blocked || moving:
		return false
	
	var new_position = dir * Constants.TILE_SIZE
	ray.target_position = new_position
	ray.force_raycast_update()
	
	var tween_speed = 1.00/speed
	
	if !ray.is_colliding():
		tween = create_tween()
		tween.tween_property(parent, NodeExtensor.POSITION_PROPERTIES, parent.position + new_position, tween_speed).set_trans(Tween.TRANS_SINE)
		
		moving = true
		await tween.finished
		tween.kill()
		moving = false
		
		return true
	
	var collider = ray.get_collider()
	if EngineUtils.is_in_group(collider,parent.defeat_groups):
		tween = create_tween()
		await collider.defeat()
		collider.queue_free()
		
		if parent.consumable:
			tween.stop()
			tween.kill()
			parent.queue_free()
			return true;
		
		tween.tween_property(parent, NodeExtensor.POSITION_PROPERTIES, parent.position + new_position, tween_speed).set_trans(Tween.TRANS_SINE)
		
		moving = true
		await tween.finished
		tween.kill()
		moving = false
		return true
	
	var shake_direction = Direction.NONE
	
	if dir.x != 0:
		shake_direction = Direction.LEFT
		
	if dir.y != 0:
		shake_direction = Direction.UP
	
	SignalDatabase.camera_shake.emit(shake_direction)
	sounds.block_sound_play_requested.emit()
	return false
