extends Camera2D

@onready var timer : Timer = $Timer 

var shake_amount = 0
var default_offset = offset
var direction : int = Direction.NONE
var shaking : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	SignalDatabase.camera_shake.connect(shake)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if direction == Direction.NONE:
		offset = Vector2(randf_range(-1,1) * shake_amount,randf_range(-1,1) * shake_amount)
	elif direction == Direction.UP or direction == Direction.DOWN:
		offset = Vector2(0,randf_range(-1,1) * shake_amount)
	elif direction == Direction.RIGHT or direction == Direction.LEFT:
		offset = Vector2(randf_range(-1,1) * shake_amount,0)

func shake(dir : int = Direction.NONE, time : float = .2, amount : float = 3):
	
	if shaking: 
		return
	
	shaking = true
	direction = dir
	timer.wait_time = time
	shake_amount = amount
	set_process(true)
	timer.start()


func _on_timer_timeout():
	set_process(false)
	var tween = create_tween()
	tween.tween_property(self,"offset",default_offset,.5)
	await tween.finished
	shaking  = false
