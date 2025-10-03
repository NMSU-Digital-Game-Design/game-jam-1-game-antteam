extends Node2D

@export var speed: float = 80   # move speed


signal hit(current_health)
signal won
signal died
signal timeout(red_ant)   # NEW signal when timer runs out

var player: Node2D = null
var health: int = 5
var in_combat: bool = false

func _ready():
	# find the player in the scene by group
	var players = get_tree().get_nodes_in_group("Player")
	if players.size() > 0:
		player = players[0]   # take the first player found

	connect("died", Callable(player, "exit_combat"))
	connect("won", Callable(player, "exit_combat"))
	# initialize health bar
	#$HealthBar.max_value = health
	#$HealthBar.value = health

func show_enemy_health(max_health: int, name: String = "Enemy"):
	$EnemyHealthLabel.text = name
	$EnemyHealthBar.max_value = max_health
	$EnemyHealthBar.value = max_health
	$EnemyHealthLabel.show()
	$EnemyHealthBar.show()
	
func update_enemy_health(current: int):
	$EnemyHealthBar.value = current

func hide_enemy_health():
	$EnemyHealthLabel.hide()
	$EnemyHealthBar.hide()
	
func take_hit():
	health -= 1
	print("RedAnt hit! Health: ", health)
	if health <= 0:
		print("RedAnt defeated!")
		queue_free()   # remove ant
		died.emit()

func start_combat_timer():
	player.connect("hit_enemy", Callable(self, "take_hit"))
	$CombatTimer.start()

func _on_combat_timer_timeout():
	print("RedAnt survived the combat! Player loses 1 life.")
	emit_signal("timeout", self)
	won.emit()
	queue_free()



func _process(delta):
	if not player:
		return
	if in_combat:
		return   # freeze ant during combat
	var direction = (player.position - position).normalized()
	position.x += direction.x * speed * delta

#signal start_combat(player, red_ant)
func _on_detector_body_entered(body):
	print("[DEBUG] Detector triggered! Body entered:", body.name)
	if body.is_in_group("Player"):
		print("[DEBUG] Player touched the red ant! Trigger combat.")
		body.in_combat = true
		in_combat = true
		start_combat()

func start_combat():
	$EnemyHealthBar.show()
	$EnemyHealthLabel.show()
	start_combat_timer()
	
		
