# Developed by Renae
extends Area2D
@export var points:= 1
func _on_body_entered(body: Node2D) -> void:
	print("Collected!")
	# adds to the score in the Globabl Variables for Player
	GvPlayer.check_score(points)
	GvPlayer.sugar_cube += 1
	queue_free()
