extends Node2D

signal end_game
@onready var checkpoints_node: Node = $Checkpoints

func _ready() -> void:
	connect("end_game", Callable(get_parent(), "end_game"))

func get_all_checkpoints() -> Array:
	var checkpoints = []
	for child in checkpoints_node.get_children():
		if child.is_in_group("Checkpoint"):
			checkpoints.append(child)
	print(checkpoints)
	return checkpoints


func _on_end_game_body_entered(body: Node2D) -> void:
	end_game.emit()
	print("Emitting End Game.")


func _on_ant_hilll_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.in_ant_hill()


func _on_ant_hilll_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.leaving_ant_hill()
