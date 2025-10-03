extends Node2D

@onready var loading: CanvasLayer = $loading

@onready var mainMenu = "res://mainmenu/main_menu.tscn"
@onready var playground = "res://playground-test/playground.tscn"
@onready var playgroundLevel := "res://test_main/playground_game.tscn"


# When the game starts, this will force the loading scene to push the mainMenu WITHOUT 
# a loading icon
func _ready() -> void:
	loading.load_scene(mainMenu)
