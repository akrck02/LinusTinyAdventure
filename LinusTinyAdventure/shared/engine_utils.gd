class_name EngineUtils

# Get if current node is player
static func is_player(node : Node) -> bool:
	
	if not node.is_in_group("Players"):
		return false
		
	if not node.has_method("take_damage"):
		return false
	
	return true

# Get current time 
static func current_time() -> float:
	return Time.get_unix_time_from_system();

# Get UI
static func get_ui(node : Node) -> CanvasLayer:
	return node.get_tree().get_root().find_child("UI", true, false)

# Get if a node is in one of the given groups
static func is_in_group(node : Node2D, groups : Array):
	for group in groups: 
		if node.is_in_group(group):
			return true;
	return false;
