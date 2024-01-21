extends ControlInput
class_name NintendoSwitchPro

func _ready():
	interact_sprite = Constants.UI_SPRITE_GAMEPAD_PATH + Icons.gamepad_interact;
	reset_level_sprite = Constants.UI_SPRITE_GAMEPAD_PATH + Icons.gamepad_reset;
	up_sprite = Constants.UI_SPRITE_GAMEPAD_PATH + Icons.gamepad_up;
	right_sprite = Constants.UI_SPRITE_GAMEPAD_PATH + Icons.gamepad_right;
	down_sprite = Constants.UI_SPRITE_GAMEPAD_PATH + Icons.gamepad_down;
	left_sprite = Constants.UI_SPRITE_GAMEPAD_PATH + Icons.gamepad_left;
	cancel_sprite = Constants.UI_SPRITE_GAMEPAD_PATH + "NOIMPLEMENTED";
	start_sprite = Constants.UI_SPRITE_GAMEPAD_PATH + Icons.gamepad_start;

	interact_sprite_pressed = Constants.UI_SPRITE_GAMEPAD_PATH + Icons.gamepad_interact_pressed;
	reset_level_sprite_pressed = Constants.UI_SPRITE_GAMEPAD_PATH + Icons.gamepad_reset_pressed;
	up_sprite_pressed = Constants.UI_SPRITE_GAMEPAD_PATH + Icons.gamepad_up_pressed;
	right_sprite_pressed = Constants.UI_SPRITE_GAMEPAD_PATH + Icons.gamepad_right_pressed;
	down_sprite_pressed = Constants.UI_SPRITE_GAMEPAD_PATH + Icons.gamepad_down_pressed;
	left_sprite_pressed = Constants.UI_SPRITE_GAMEPAD_PATH + Icons.gamepad_left_pressed;
	cancel_sprite_pressed = Constants.UI_SPRITE_GAMEPAD_PATH + "NOIMPLEMENTED_PRESSED";
	start_sprite_pressed = Constants.UI_SPRITE_GAMEPAD_PATH + Icons.gamepad_start_pressed;

