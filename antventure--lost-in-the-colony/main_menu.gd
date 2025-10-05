extends Control

@onready var credits: ColorRect = $Credits
@onready var playgroundLevel := "res://test_main/playground_game.tscn"
@onready var level_loader := "res://level_loader.tscn"


func _on_play_button_pressed() -> void:
	Loading.load_scene(level_loader, true)


func _on_credit_buttons_pressed() -> void:
	credits.show()

func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	Loading.load_scene(playgroundLevel, true)


func _on_return_button_pressed() -> void:
	credits.hide()
