extends Control


@onready var mainMenu = "res://mainmenu/main_menu.tscn"

func _on_timer_timeout() -> void:
	Loading.load_scene(mainMenu)
