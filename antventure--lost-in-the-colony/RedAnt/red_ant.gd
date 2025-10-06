extends Node2D

@export var speed: float = 80   # move speed
@export var max_health := 10
@export var difficulty_timer = .5
@export var able_to_move:= true
var points:= 50

@onready var enemy_health_bar: ProgressBar = $EnemyHealthBar
@onready var fight_timer: Timer = $FightTimer

signal hit(current_health)
signal combat_start
signal won
signal died
signal timeout(red_ant)   # NEW signal when timer runs out

var player: Node2D = null
var in_combat: bool = false
var see_player: bool = false
var health := max_health/2

func _ready():
	# find the player in the scene by group
	var players = get_tree().get_nodes_in_group("Player")
	if players.size() > 0:
		player = players[0]   # take the first player found
	enemy_health_bar.max_value = max_health
	enemy_health_bar.value = health

	connect("died", Callable(player, "exit_combat"))
	connect("won", Callable(player, "exit_combat"))
	connect("combat_start", Callable(player, "enter_combat"))

func _process(delta):
	if not player:
		return
	if in_combat:
		return   # freeze ant during combat
	if !GvPlayer.in_combat and see_player and able_to_move:
		var direction = (player.position - position).normalized()
		position.x += direction.x * speed * delta

	
func take_hit():
	health += 1
	enemy_health_bar.value = health
	if health >= max_health:
		print("RedAnt defeated!")
		GvPlayer.check_score(points)
		GvPlayer.ant_defeated += 1
		died.emit()
		queue_free()   # remove ant


func start_combat_timer():
	player.connect("hit_enemy", Callable(self, "take_hit"))


#signal start_combat(player, red_ant)
func _on_detector_body_entered(body):
	print("[DEBUG] Detector triggered! Body entered:", body.name)
	if body.is_in_group("Player"):
		print("[DEBUG] Player touched the red ant! Trigger combat.")
		in_combat = true
		start_combat()

func start_combat():
	$EnemyHealthBar.show()
	start_combat_timer()
	combat_start.emit()
	fight_timer.start(difficulty_timer)

func _on_follow_player_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		see_player = true

func _on_follow_player_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		see_player = false


func _on_fight_timer_timeout() -> void:
	health -= 1
	enemy_health_bar.value = health
	if health == max_health:
		won.emit()
		GvPlayer.decrease_score(points)
