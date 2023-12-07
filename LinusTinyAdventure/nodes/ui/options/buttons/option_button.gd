extends Button

func _on_focus_entered():
	var tween = self.create_tween()
	var new_position = Vector2(position.x,2)
	tween.tween_property(self,"position",new_position, 1.00/3.5).set_trans(Tween.TRANS_SINE)
	Input.start_joy_vibration(0,.1,0.2,0.25)
	await tween.finished

func _on_focus_exited():
	var tween = self.create_tween()
	var new_position = Vector2(position.x,32)
	tween.tween_property(self,"position",new_position, 1.00/3.5).set_trans(Tween.TRANS_SINE)
	Input.start_joy_vibration(0,.1,0.2,0.25)
	await tween.finished
