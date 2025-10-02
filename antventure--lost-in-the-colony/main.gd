extends Node2D

@onready var ant_hill = $Playground/AntHill   # reference to  AntHill
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Main scene ready!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_out_of_lives() -> void:
	get_tree().quit()


func _on_red_ant_timer_timeout():
	ant_hill.spawn_ant()
