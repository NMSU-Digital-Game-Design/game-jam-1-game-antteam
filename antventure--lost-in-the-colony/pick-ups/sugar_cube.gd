# Developed by Renae
extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("Collected!")
	# adds to the score in the Globabl Variables for Player
	GvPlayer.score += 1
	# deletes the sugar cube
	queue_free()
