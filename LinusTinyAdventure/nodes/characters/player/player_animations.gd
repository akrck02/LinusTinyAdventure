extends AnimationPlayer

const IDLE_ANIMATION_NAME = "idle"

# Called when the node enters the scene tree for the first time.
func _ready():
	play(IDLE_ANIMATION_NAME)

