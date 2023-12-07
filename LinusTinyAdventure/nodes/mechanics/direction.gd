class_name Direction
enum {
	UP = 0, 
	RIGHT = 1,
	DOWN = 2,
	LEFT = 3,
	NONE = -1
}

const list = [UP,RIGHT,DOWN,LEFT,NONE]


# Get random direction
static func get_random_direction() -> int : 
	return Direction.list[randi() % Direction.list.size()]
