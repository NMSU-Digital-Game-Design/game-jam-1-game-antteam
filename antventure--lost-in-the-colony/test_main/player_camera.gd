extends Camera2D

var zoom_default := Vector2(1, 1)
var zoom_battle := Vector2(5, 5)
var zoom_underground := Vector2(2.5, 2.5)
var battle_offset := Vector2(40, 0)

var in_underground:= false

const bottom_overworld:= 890
const left_overworld:= 377
const right_overworld:= 9142
const up_overworld:= -755

const bottom_underground:= 2424
const left_underground:= 228
const right_underground:= 5916
const up_underground:= 773

func _ready() -> void:
	pass

func zoom_in_on_battle(direction_facing):
	offset = direction_facing * battle_offset
	zoom = zoom_battle

func return_to_normal():
	if !in_underground:
		zoom = zoom_default
		offset = Vector2(0, 0)
		limit_bottom = bottom_overworld
		limit_right = right_overworld
		limit_top = up_overworld
		limit_left = left_overworld

func zoom_in_underground():
	in_underground = true
	zoom = zoom_underground
	limit_bottom = bottom_underground
	limit_left = left_underground
	limit_right = right_underground
	limit_top = up_underground
