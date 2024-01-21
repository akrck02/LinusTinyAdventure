extends ControlInput
class_name Keyboard

func _ready():
	interact_sprite = Constants.UI_SPRITE_KEYBOARD_PATH + Icons.keyboard_interact_pressed;
	reset_level_sprite= Constants.UI_SPRITE_KEYBOARD_PATH + Icons.keyboard_reset_pressed;
	up_sprite = Constants.UI_SPRITE_KEYBOARD_PATH + Icons.keyboard_up_pressed;
	right_sprite = Constants.UI_SPRITE_KEYBOARD_PATH + Icons.keyboard_right_pressed;
	down_sprite = Constants.UI_SPRITE_KEYBOARD_PATH + Icons.keyboard_down_pressed;
	left_sprite = Constants.UI_SPRITE_KEYBOARD_PATH + Icons.keyboard_left_pressed;
	cancel_sprite  = Constants.UI_SPRITE_KEYBOARD_PATH + "NOIMPLEMENTED_PRESSED";
	start_sprite = Constants.UI_SPRITE_KEYBOARD_PATH + Icons.keyboard_start_pressed;

	interact_sprite_pressed = Constants.UI_SPRITE_KEYBOARD_PATH + Icons.keyboard_interact_pressed;
	reset_level_sprite_pressed = Constants.UI_SPRITE_KEYBOARD_PATH + Icons.keyboard_reset_pressed;
	up_sprite_pressed = Constants.UI_SPRITE_KEYBOARD_PATH + Icons.keyboard_up_pressed;
	right_sprite_pressed = Constants.UI_SPRITE_KEYBOARD_PATH + Icons.keyboard_right_pressed;
	down_sprite_pressed = Constants.UI_SPRITE_KEYBOARD_PATH + Icons.keyboard_down_pressed;
	left_sprite_pressed = Constants.UI_SPRITE_KEYBOARD_PATH + Icons.keyboard_left_pressed;
	cancel_sprite_pressed = Constants.UI_SPRITE_KEYBOARD_PATH + "NOIMPLEMENTED_PRESSED";
	start_sprite_pressed = Constants.UI_SPRITE_KEYBOARD_PATH + Icons.keyboard_start_pressed;

