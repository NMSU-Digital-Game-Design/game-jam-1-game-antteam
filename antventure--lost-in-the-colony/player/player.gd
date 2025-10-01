extends CharacterBody2D
signal out_of_lives
signal hit
var current_enemy: Node = null   # store the RedAnt during combat
var lives := 3
var in_combat := false   # starting lives

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if !in_combat:
		# adds wall climb mechanic
		if is_on_wall():
			var direction := Input.get_axis("up", "down")
			if direction:
				velocity.y = direction * SPEED
			else:
				velocity.y = move_toward(velocity.y, 0, SPEED)
			if Input.is_action_pressed("left") or Input.is_action_pressed("right") and Input.is_action_pressed("jump"):
				direction = Input.get_axis("left", "right")
				if direction:
					velocity.x = direction * SPEED
					velocity.y = jump()
		
		# applies gravity and allows player to move around while falling
		elif not is_on_floor():
			velocity += get_gravity() * delta
			var direction := Input.get_axis("left", "right")
			if direction:
				velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
		# regular ground movement and jump
		else:
			# Handle jump.
			if Input.is_action_pressed("jump") and is_on_floor():
				velocity.y = jump()


			# Get the input direction and handle the movement/deceleration.
			# As good practice, you should replace UI actions with custom gameplay actions.
			var direction := Input.get_axis("left", "right")
			if direction:
				velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
	elif in_combat:
		if Input.is_action_just_pressed("select"):
			hit.emit()  # usually Space/Enter
			print("Player attacked!")
			if current_enemy:
				current_enemy.take_hit()
				if current_enemy.health <= 0:
					print("Enemy defeated!")
					current_enemy.queue_free()   # remove the red ant
					exit_combat()                # let the player move again
					current_enemy = null
		

###### MOVEMENTS FUNCTIONS ######

func jump():
	return JUMP_VELOCITY
	
##### COMBAT #####

func enter_combat():
	in_combat = true
	print("Entering combat mode... Player can’t move now.")
func exit_combat():
	in_combat = false
	print("Exiting combat mode... Player can move again.")

func lose_life():
	GvPlayer.player_health -= 1
	print("Player lost a life! Lives left: ", GvPlayer.player_health)
	get_tree().root.get_node("Main/HUD").update_lives(GvPlayer.player_health)
	
	
func hurt(dmg: int):
	var health = GvPlayer.player_health
	health -= 1
	if health == 0:
		out_of_lives.emit()
	GvPlayer.player_health = health
	print("Hit!")

func connect_enemy(enemy):
	pass
