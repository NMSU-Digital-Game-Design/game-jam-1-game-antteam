extends Area2D
signal attack(damage: int)

@export var points_taken: int = 10

@export var damage: int = 1


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.hurt(damage)
		GvPlayer.decrease_score(points_taken)
