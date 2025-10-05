extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_out_of_lives() -> void:
	get_tree().quit()
@onready var loading: CanvasLayer = $loading

@onready var mainMenu = "res://mainmenu/main_menu.tscn"
@onready var playground = "res://playground-test/playground.tscn"
@onready var playgroundLevel := "res://test_main/playground_game.tscn"


# When the game starts, this will force the loading scene to push the mainMenu WITHOUT 
# a loading icon
func _ready() -> void:
	loading.load_scene(mainMenu)
