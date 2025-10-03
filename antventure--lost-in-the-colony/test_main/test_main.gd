extends Node2D


@onready var loading: CanvasLayer = $loading

@onready var mainMenu = "res://test_main/test_main_menu.tscn"
@onready var playground = "res://playground-test/playground.tscn"
@onready var playgroundLevel := "res://test_main/playground_game.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loading.load_scene(mainMenu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
