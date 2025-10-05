extends Area2D

@export var fall_speed: float = 200.0
@export var damage: int = 1
@export var splash_scene: PackedScene = preload("res://water_splash.tscn")# assign WaterSplash.tscn in inspector

func _physics_process(delta: float) -> void:
	position.y += fall_speed * delta

	# delete when off-screen (falling too far)
	if position.y > 1200:
		create_splash()
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.take_damage(damage)
	create_splash()
	queue_free()

func create_splash() -> void:
	if splash_scene:
		var splash = splash_scene.instantiate()
		get_parent().add_child(splash)
		splash.global_position = global_position
