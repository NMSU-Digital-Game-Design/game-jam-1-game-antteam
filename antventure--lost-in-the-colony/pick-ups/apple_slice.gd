# Developed by Renae
extends Area2D
var points:= 25

func _on_body_entered(body: Node2D) -> void:
	print("Collected!")
	# adds to the score in the Globabl Variables for Player
	# deletes the sugar cube
	GvPlayer.check_score(points)
	queue_free()
