extends Node
var current_ant: Node = null
@export var red_ant_scene: PackedScene
func _ready():
	print("Main scene ready!")
	$HUD.update_lives($Player.lives)

func _on_red_ant_start_combat(player, red_ant):
	current_ant = red_ant
	player.current_enemy = red_ant   # use the actual RedAnt that collided
	player.enter_combat()
	$HUD.show_enemy_health(red_ant.health, "Red Ant")
	# connect signals for health updates
	red_ant.connect("hit", Callable(self, "_on_ant_hit"))
	red_ant.connect("died", Callable(self, "_on_ant_died"))
	red_ant.start_combat_timer()
	
func _on_ant_hit(current_health):
	$HUD.update_enemy_health(current_health)
func _on_ant_died(red_ant):
	if current_ant == red_ant:
		$HUD.hide_enemy_health()
		current_ant = null
		$Player.exit_combat()
		print("RedAnt died, scheduling next spawn...")
		$RedAntTimer.start()   # wait for the next ant
	#print("Combat started with a RedAnt that has ", red_ant.health, " health.")

func _on_red_ant_timer_timeout():
	spawn_red_ant()

func spawn_red_ant():
	if current_ant != null:
		print("Skipped spawn: already in combat with an ant.")
		return
	var red_ant = red_ant_scene.instantiate()
	add_child(red_ant)
	red_ant.position = Vector2(randi_range(100, 600), randi_range(100, 400)) # random spawn area
	
	# connect signals
	red_ant.start_combat.connect(_on_red_ant_start_combat)
	red_ant.hit.connect(_on_ant_hit)
	red_ant.died.connect(_on_ant_died)
	red_ant.timeout.connect(_on_ant_timeout)
	
	print("Spawned a new RedAnt")
func _on_ant_timeout(red_ant):
	print("RedAnt survived! Player loses 1 life.")
	$Player.lives -= 1
	$HUD.update_lives($Player.lives)

	# allow player to move again
	$Player.exit_combat()

	# clean up if that ant was the current one
	if current_ant == red_ant:
		$HUD.hide_enemy_health()
		current_ant = null
	#Check for Game Over
	if $Player.lives <= 0:
		print("GAME OVER")
		$HUD.show_game_over()
		get_tree().paused = true   # optional: freezes everything
