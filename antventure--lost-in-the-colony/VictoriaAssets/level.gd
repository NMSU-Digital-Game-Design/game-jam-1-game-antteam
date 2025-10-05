extends Node2D
@onready var checkpoints_node: Node = $Checkpoints

func get_all_checkpoints() -> Array:
	var checkpoints = []
	for child in checkpoints_node.get_children():
		if child.is_in_group("Checkpoint"):
			checkpoints.append(child)
	print(checkpoints)
	return checkpoints
