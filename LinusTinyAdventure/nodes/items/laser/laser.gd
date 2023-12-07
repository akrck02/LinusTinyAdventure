extends Node2D
class_name Laser

const MAX_LENGTH = 2000

@onready var ray : RayCast2D = $RayCast2D
@onready var line : Line2D = $Line2D 
@onready var end : Sprite2D = $End

@export var enabled : bool = true

func _physics_process(_delta):

	if(not enabled):
		return;

	var max_cast_to = Vector2.UP * MAX_LENGTH
	ray.target_position = max_cast_to
	
	if ray.is_colliding():
		end.global_position = ray.get_collision_point()
		
		var collider = ray.get_collider();
		
		if (collider.is_in_group(Groups.PLAYER)):
			LevelManager.reset_level()
			return
		
		line.points[1] = end.position 
	
func off():
	enabled = false;
	ray.enabled = false;
	line.visible = false;

func on():
	enabled = true;
	ray.enabled = false;
	line.visible = false;
