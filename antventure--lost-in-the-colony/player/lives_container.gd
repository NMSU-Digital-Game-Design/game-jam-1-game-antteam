extends HBoxContainer
@onready var LiveGUIClass = preload("res://player/live.tscn")
var lives: Array = []

func _ready() -> void:
	# Initialize with the starting player health
	update_lives(GvPlayer.starting_player_health)

func _process(delta: float) -> void:
	# Check if the player's health changed and update hearts
	if GvPlayer.player_health != lives.size():
		update_lives(GvPlayer.player_health)

func update_lives(new_health: int) -> void:
	# If we need to add hearts
	while lives.size() < new_health:
		var live = LiveGUIClass.instantiate()
		add_child(live)
		lives.append(live)
	
	# If we need to remove hearts
	while lives.size() > new_health:
		var last_live = lives.pop_back()
		last_live.queue_free()
