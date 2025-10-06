extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("Leaf Upgrade Got!")
	GvPlayer.LeafUpgrade = true
	queue_free()
