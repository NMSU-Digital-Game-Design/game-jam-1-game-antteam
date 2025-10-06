extends Node2D

signal end_game
@onready var checkpoints_node: Node = $Checkpoints
@onready var sugar_cubes: Node = $FoodItems/SugarCubes
@onready var apple_slices: Node = $FoodItems/AppleSlices
@onready var ant_hill_ants: Node = $AntHillAnts
@onready var over_world_red_ants: Node = $OverWorldRedAnts
@onready var grab_upgrade_level: Label = $Directions/GrabUpgradeLevel
@onready var jump_upgrade: Label = $Directions/JumpUpgrade


func _ready() -> void:
	GvLevel.all_food = get_sugarcube_count() + get_apple_slices_count()
	GvLevel.all_red_ants = get_ant_count()
	GvLevel.max_score = get_max_score()
	connect("end_game", Callable(get_parent(), "end_game"))

func _process(delta: float) -> void:
	if GvPlayer.LeafUpgrade:
		grab_upgrade_level.hide()
	if GvPlayer.JumpUpgrade:
		jump_upgrade.hide()
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

func get_ant_count() -> int:
	var num_ant = ant_hill_ants.get_child_count() + over_world_red_ants.get_child_count()
	return num_ant
func get_sugarcube_count() -> int:
	var num_sugarcube = sugar_cubes.get_child_count()
	return num_sugarcube
func get_apple_slices_count() -> int:
	var num_apple = apple_slices.get_child_count()
	return num_apple
func get_max_score() -> int:
	return get_sugarcube_count() + get_apple_slices_count() * 25 + get_ant_count() * 50
