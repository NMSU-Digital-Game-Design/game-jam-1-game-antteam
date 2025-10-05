extends Camera2D

var zoom_default := Vector2(1, 1)
var zoom_battle := Vector2(5, 5)
var zoom_underground := Vector2(5,5)
var battle_offset := Vector2(40, 0)

func _ready() -> void:
	pass

func zoom_in_on_battle(direction_facing):
	offset = direction_facing * battle_offset
	zoom = zoom_battle

func return_to_normal():
	zoom = zoom_default

func zoom_in_underground():
	pass
