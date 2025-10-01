extends CanvasLayer
@onready var lives_label = $LivesLabel
func _ready():
	# Hide enemy health bar at start
	$EnemyHealthLabel.hide()
	$EnemyHealthBar.hide()

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
func update_lives(lives: int):
	lives_label.text = "Lives: " + str(lives)
func show_game_over():
	$GameOverScreen.visible = true
