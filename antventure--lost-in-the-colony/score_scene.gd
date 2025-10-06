extends CanvasLayer
@onready var leaf_sprite: Sprite2D = $control/VBoxContainer/Upgrades/LeafUpgrade/Sprite2D
@onready var jump_sprite: Sprite2D = $control/VBoxContainer/Upgrades/JumpUpgrade/Sprite2D
@onready var upgrade_timer: Timer = $UpgradeTimer
@onready var final_points_label: Label = $control/VBoxContainer/FinalPoints
@onready var food_timer: Timer = $FoodTimer
@onready var food_label: Label = $control/VBoxContainer/FoodLabel
@onready var upgrades: HBoxContainer = $control/VBoxContainer/Upgrades
@onready var ant_labels: Label = $control/VBoxContainer/AntLabels

@onready var star_1: Sprite2D = $control/Stars/Star1/Sprite2D
@onready var star_2: Sprite2D = $control/Stars/Star2/Sprite2D
@onready var star_3: Sprite2D = $control/Stars/Star3/Sprite2D

var upgrade_shown:= 0
var score:= 0
func final_points():
	final_points_label.show()
	final_points_label.text = str("Final Score: " , GvPlayer.score, "/", GvLevel.max_score)
	food_timer.start()
func food():
	food_label.show()
	food_label.text = str("Food Obtained: ", GvPlayer.sugar_cube + GvPlayer.apple_slices, "/", GvLevel.all_food)
	upgrade()
func upgrade():
	upgrade_timer.start()
	
func ant_defeated():
	ant_labels.show()
	ant_labels.text = str("Ants Defeated: ", GvPlayer.ant_defeated, "/" , GvLevel.all_red_ants)
	calculating_score()

func _on_upgrade_timer_timeout() -> void:
	if upgrade_shown == 0:
		if GvPlayer.LeafUpgrade:
			leaf_sprite.show()
		upgrade_shown += 1
		print(upgrade_shown)
		upgrade_timer.start()
	elif upgrade_shown == 1:
		if GvPlayer.JumpUpgrade:
			jump_sprite.show()
		upgrade_shown += 1
		upgrade_timer.start()
		print(upgrade_shown)
	else:
		print(upgrade_shown)
		ant_defeated()

func _on_loading_timeout() -> void:
	final_points()


func _on_food_timer_timeout() -> void:
	food()

func _on_ant_timer_timeout() -> void:
	ant_defeated()

func calculating_score():
	var player_wins = GvPlayer.ant_defeated
	var all_ants = GvLevel.all_red_ants
	if GvPlayer.LeafUpgrade and GvPlayer.JumpUpgrade:
		score += 1
	elif GvPlayer.LeafUpgrade and !GvPlayer.JumpUpgrade or !GvPlayer.LeafUpgrade and GvPlayer.JumpUpgrade:
		score += 0.5
	if GvPlayer.score == GvLevel.max_score:
		score += 1
	elif GvLevel.max_score/2 <= GvPlayer.score:
		score += .5
	if GvPlayer.sugar_cube + GvPlayer.apple_slices == GvLevel.all_food:
		score += .5
	if player_wins == all_ants:
		score += .5
	if score == 0:
		pass
	elif score == 0.5:
		star_1.frame = 1
	elif score == 1:
		star_1.frame = 0
	elif score == 1.5:
		star_1.frame = 0
		star_2.frame = 1
	elif score == 2:
		star_1.frame = 0
		star_2.frame = 0
	elif score == 2.5:
		star_1.frame = 0
		star_2.frame = 0
		star_3.frame = 1
	elif score >= 3:
		star_1.frame = 0
		star_2.frame = 0
		star_3.frame = 0
