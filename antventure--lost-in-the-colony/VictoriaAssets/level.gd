extends Node2D

@onready var checkpoints_node: Node = $Checkpoints


@export var droplet_scene: PackedScene = preload("res://rain_droplets.tscn")
@export var spawn_area_width: float = 1024.0
@export var spawn_height: float = -685.0
@export var spawn_interval: float = 1.5

var spawn_timer: float = 0.0

func get_all_checkpoints() -> Array:
	var checkpoints = []
	for child in checkpoints_node.get_children():
		if child.is_in_group("Checkpoint"):
			checkpoints.append(child)
	print(checkpoints)
	return checkpoints



func _process(delta: float) -> void:
	spawn_timer -= delta
	if spawn_timer <= 0:
		spawn_random_droplet()
		spawn_timer = randf_range(spawn_interval * 0.5, spawn_interval * 1.5)

func spawn_random_droplet() -> void:
	if droplet_scene == null:
		return
	var droplet = droplet_scene.instantiate()
	var random_x = randf_range(682, spawn_area_width)
	droplet.position = Vector2(random_x, spawn_height)
	add_child(droplet)
