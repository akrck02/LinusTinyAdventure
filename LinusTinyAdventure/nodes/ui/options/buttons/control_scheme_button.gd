extends Node2D

@export var selected_sprite_path : String = Constants.UI_SPRITE_GAMEPAD_PATH + Icons.gamepad_down;
@export var unselected_sprite_path : String = Constants.UI_SPRITE_GAMEPAD_PATH + Icons.gamepad_down_pressed;
@export var control_name : String = "Control";

@onready var selected_sprite : Sprite2D = $SelectedSprite
@onready var unselected_sprite : Sprite2D = $UnselectedSprite
@onready var label : RichTextLabel = $Label

func _ready():
	label.bbcode_enabled = true
	label.text = "[center]" + control_name + "[/center]";

func press():
	unselected_sprite.hide()
	selected_sprite.show()

func release():
	selected_sprite.hide() 
	unselected_sprite.show()
