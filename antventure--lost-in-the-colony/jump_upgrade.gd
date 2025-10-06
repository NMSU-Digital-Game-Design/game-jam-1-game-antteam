extends Area2D


func _on_body_entered(body: Node2D) -> void:
	GvPlayer.JumpUpgrade = true
	body.JUMP_VELOCITY -= 200
	queue_free()
