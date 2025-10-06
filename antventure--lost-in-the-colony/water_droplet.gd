extends Area2D

func _on_body_entered(body: Node2D) -> void:
	GvPlayer.player_health -= 1
	print("hit by water droplet!")
