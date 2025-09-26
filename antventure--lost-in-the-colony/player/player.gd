extends CharacterBody2D
signal out_of_lives

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	
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

###### MOVEMENTS FUNCTIONS ######

func jump():
	return JUMP_VELOCITY
	
##### Damage #####

func hurt(dmg: int):
	var health = GvPlayer.player_health
	health -= 1
	if health == 0:
		out_of_lives.emit()
	GvPlayer.player_health = health
	print("Hit!")
