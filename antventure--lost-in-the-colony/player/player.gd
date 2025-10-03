extends CharacterBody2D
signal out_of_lives
signal hit_enemy


@onready var player_camera: Camera2D = $PlayerCamera

var current_enemy: Node = null   # store the RedAnt during combat
var lives := 3
var direction_facing := 1
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if !GvPlayer.in_combat:
		# adds wall climb mechanic
		if is_on_wall():
			var direction := Input.get_axis("up", "down")
			if direction:
				velocity.y = direction * SPEED
			else:
				velocity.y = move_toward(velocity.y, 0, SPEED)
			if Input.is_action_pressed("left") or Input.is_action_pressed("right") and Input.is_action_pressed("jump"):
				direction = Input.get_axis("left", "right")
				direction_facing = direction

				if direction:
					velocity.x = direction * SPEED
					velocity.y = jump()
		
		# applies gravity and allows player to move around while falling
		elif not is_on_floor():
			velocity += get_gravity() * delta
			var direction := Input.get_axis("left", "right")
			direction_facing = direction

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
			direction_facing = direction
			if direction:
				velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				

		move_and_slide()
	elif GvPlayer.in_combat:
		if Input.is_action_just_pressed("select"):
			hit_enemy.emit() # usually Space/Enter
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

# Player will enter combat and will connect the hit enemy signal to the current
# enemy's "take_hit" function
func enter_combat():
	GvPlayer.in_combat = true
	connect("hit_enemy", Callable(current_enemy, "take_hit"))
	print("Entering combat mode... Player can’t move now.")
	player_camera.zoom_in_on_battle(direction_facing)

# Player will exit out of combat and will set the current_enemy to null

func exit_combat():
	GvPlayer.in_combat = false
	current_enemy = null
	print("Exiting combat mode... Player can move again.")
	player_camera.return_to_normal()
	
	
func hurt(dmg: int):
	var health = GvPlayer.player_health
	health -= 1
	if health == 0:
		out_of_lives.emit()
	GvPlayer.player_health = health
	print("Hit!")
