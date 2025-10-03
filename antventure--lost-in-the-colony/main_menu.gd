extends Control

@onready var playgroundLevel := "res://test_main/playground_game.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	print("Please add level node!")


func _on_credit_buttons_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	Loading.load_scene(playgroundLevel, true)
