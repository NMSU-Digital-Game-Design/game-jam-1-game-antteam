# The HUD should be used for anything that needs to be on screen at all times i.e. score,
# time, lives, etc.
extends Control

@onready var pause: Control = $PAUSE
@onready var play_info: ColorRect = $PAUSE/PlayInfo

@onready var score_label: Label = $ScoreLabel
var is_paused:= false
var how_to_play_on := false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# updates should be done by functions and grouped together
	# if there are any additional things added to the HUD please create a new function to help with
	# updating things for the HUD
	update_labels()


# if we have labels that need to constantly be updated due to global variables, make these changes
# here. 
func update_labels():
	score_label.text = str("Score: " , GvPlayer.score)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_paused:
			pause.hide()
			is_paused = false
			get_tree().paused = false
		elif !is_paused:
			pause.show()
			is_paused = true
			get_tree().paused = true

func _on_how_to_play_button_pressed() -> void:
	if how_to_play_on:
		play_info.hide()
		how_to_play_on = false
	elif !how_to_play_on:
		play_info.show()
		how_to_play_on = true
