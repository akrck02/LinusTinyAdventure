extends Button

@export var label : String
@export var texture : Texture2D

@onready var button_label : RichTextLabel = $ButtonLabel
@onready var button_sprite_2D : Sprite2D = $ButtonSprite2D
@onready var original_y : float = position.y 
@onready var focused_y : float = position.y - 30

func _ready():
	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)
	
	button_label.bbcode_enabled = true
	button_label.text  = "[center]" + label + "[/center]"
	
	button_sprite_2D.texture = texture
	button_sprite_2D.set_scale(Vector2(.5,.5))

func _on_focus_entered():
	var tween = self.create_tween()
	var new_position = Vector2(position.x,focused_y)
	tween.tween_property(self,"position",new_position, 1.00/3.5).set_trans(Tween.TRANS_SINE)
	Input.start_joy_vibration(0,.1,0.2,0.25)
	await tween.finished

func _on_focus_exited():
	var tween = self.create_tween()
	var new_position = Vector2(position.x,original_y)
	tween.tween_property(self,"position",new_position, 1.00/3.5).set_trans(Tween.TRANS_SINE)
	Input.start_joy_vibration(0,.1,0.2,0.25)
	await tween.finished
