extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("exit_level")
	$Node/Player/AnimationPlayer.play("idle");
	$Label/AnimationPlayer.play("idle")
