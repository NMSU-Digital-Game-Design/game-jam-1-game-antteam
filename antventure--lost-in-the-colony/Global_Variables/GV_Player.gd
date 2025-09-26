extends Node

const max_player_health = 5
const starting_player_health = 3
var player_health = 3 :
	set(value):
		player_health = clampi(value,0,max_player_health)

var score:= 0
var raise_health = 5
var max_points:= score

func check_score(points: int):
	score += points
	if points > raise_health:
		player_health += 1
	elif score % raise_health == 0:
		player_health += 1
	#### Testing this Code #### 
	#var difference = score % raise_health
	#if max_points > score and (score + points) < max_points:
		#pass
	#elif difference > points:
		#player_health += 1
	#elif score % raise_health == 0 and score != 0:
		#player_health += 1
	#score += points

func decrease_score(points: int):
	if score - points <= 0:
		score = 0
	else:
		score -= points
