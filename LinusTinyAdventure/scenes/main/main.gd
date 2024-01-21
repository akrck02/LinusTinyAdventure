extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed(Controls.START) || Input.is_action_just_pressed(Controls.INTERACT):
		SignalDatabase.scene_change_requested.emit(Constants.SELECTOR_SCENE_PATH)
		queue_free()
