extends Camera2D

@onready var timer : Timer = $Timer 

var shake_amount = 0
var default_offset = offset

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	SignalDatabase.camera_shake.connect(shake)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset = Vector2(randf_range(-1,1) * shake_amount,randf_range(-1,1) * shake_amount)

func shake(time = .2, amount = 3):
	timer.wait_time = time
	shake_amount = amount
	set_process(true)
	timer.start()


func _on_timer_timeout():
	set_process(false)
	var tween = create_tween()
	tween.tween_property(self,"offset",default_offset,.5)
