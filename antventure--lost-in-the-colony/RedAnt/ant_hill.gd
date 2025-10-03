extends Node2D

@export var red_ant_scene: PackedScene

func spawn_ant():
	var spawn_points = get_children().filter(func(c): return c is Marker2D)
	if spawn_points.size() == 0:
		print("No spawn points in AntHill!")
		return
	
	# pick one spawn point (if multiple exist later)
	var spawn_point = spawn_points.pick_random()
	var red_ant = red_ant_scene.instantiate()
	get_parent().add_child(red_ant)  # add to Main/Playground
	red_ant.global_position = spawn_point.global_position
	print("Spawned RedAnt at AntHill:", spawn_point.name)
