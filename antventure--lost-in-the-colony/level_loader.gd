extends Node2D
@onready var level: Node2D = $level
@onready var all_checkpoints = level.get_all_checkpoints()
@onready var player: CharacterBody2D = $Player

func respawn_player(pos: Vector2):
	player.global_position = pos

func find_closets_checkpoint(position: Vector2):
	print("Respawning!")
	var checkpoints = all_checkpoints
	if checkpoints.is_empty():
		print("There are no checkpoints!")
		return Vector2(0,0)

	var closet = checkpoints[0]
	var closest_distance = position.distance_to(closet.global_position)
	
	for checkpoint in checkpoints:
		var dist = position.distance_to(checkpoint.global_position)
		if dist < closest_distance:
			closet = checkpoint
			closest_distance = dist
	print(str("Respawning to: ", closet.global_position))
	respawn_player(closet.global_position)
