extends CharacterBody2D

@export var speed = 200
var current_enemy: Node = null   # store the RedAnt during combat
var lives := 3
var in_combat := false   # starting lives
#func _ready():
 #	print("Player ready with lives: ", lives)

func _ready():
	print("Player ready with lves: ", lives)
	
func _process(delta):
	if in_combat:
		return  # freeze player when fighting
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	if velocity != Vector2.ZERO:
		position += velocity.normalized() * speed * delta
		#Keep player inside window bounds
	var screen_size = get_viewport_rect().size
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
func enter_combat():
	in_combat = true
	print("Entering combat mode... Player can’t move now.")
func exit_combat():
	in_combat = false
	print("Exiting combat mode... Player can move again.")
func _input(event):
	if in_combat and event.is_action_pressed("ui_accept"):  # usually Space/Enter
		print("Player attacked!")
		if current_enemy:
			current_enemy.take_hit()
			if current_enemy.health <= 0:
				print("Enemy defeated!")
				current_enemy.queue_free()   # remove the red ant
				exit_combat()                # let the player move again
				current_enemy = null
func lose_life():
	lives -= 1
	print("Player lost a life! Lives left: ", lives)
	get_tree().root.get_node("Main/HUD").update_lives(lives)
	
