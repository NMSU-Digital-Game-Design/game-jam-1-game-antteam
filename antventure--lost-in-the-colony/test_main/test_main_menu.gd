extends Control

const PLAYGROUND = "res://test_main/playground_game.tscn"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	Loading.load_scene(PLAYGROUND, true)
