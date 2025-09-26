# The HUD should be used for anything that needs to be on screen at all times i.e. score,
# time, lives, etc.

extends Control
@onready var score_label: Label = $ScoreLabel


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
