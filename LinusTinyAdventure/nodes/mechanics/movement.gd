extends Node2D
class_name Movement
const TILE_SIZE = 16

@onready var parent = get_parent()
@onready var ray : RayCast2D = $RayCast2D

@export var moving : bool = false
@export var blocked : bool = false
@export_range(0,10) var speed : int = 4;

var tween : Tween

# Teleport the item 
func teleport(new_position : Vector2, collider : Node2D, _dir : Vector2):
		
	if collider != null: 
		return
		
	await tween.finished
	parent.position = new_position

# Move thw item
func move(dir : Vector2): 

	if blocked || moving:
		return false
	
	var new_position = dir * TILE_SIZE
	ray.target_position = new_position
	ray.force_raycast_update()
	
	if !ray.is_colliding():
		tween = create_tween()
		tween.tween_property(parent, "position", parent.position + new_position, 1.00/speed).set_trans(Tween.TRANS_SINE)
		
		moving = true
		await tween.finished
		tween.kill()
		moving = false
		return true
	
	var collider = ray.get_collider()
	if EngineUtils.is_in_group(collider,parent.defeat_groups):
		tween = create_tween()
		collider.defeat()
		collider.queue_free()
		
	
		if parent.consumable:
			tween.stop()
			tween.kill()
			parent.queue_free()
			return true;
		
		tween.tween_property(parent, "position", parent.position + new_position, 1.00/speed).set_trans(Tween.TRANS_SINE)
		
		moving = true
		await tween.finished
		tween.kill()
		moving = false
		return true
	
	return false
