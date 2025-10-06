extends CharacterBody2D
signal out_of_lives
signal hit_enemy
signal respawn(pos: Vector2)

@onready var player_camera: Camera2D = $PlayerCamera
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_box: Area2D = $HitBox
@onready var leaf: Sprite2D = $Leaf
@onready var left_ray_cast: RayCast2D = $LeftRayCast
@onready var right_ray_cast: RayCast2D = $RightRayCast

var current_enemy: Node = null   # store the RedAnt during combat
var lives := 3

var wall_locked:= false
var on_wall = false
var wall_direction = 0

const SPEED = 300.0
var JUMP_VELOCITY = -400.0

func _ready() -> void:
	connect("out_of_lives", Callable(get_parent(), "died"))

func _physics_process(delta: float) -> void:
	if GvPlayer.player_health == 0:
		out_of_lives.emit()
	# Add the gravity.
	if !GvPlayer.in_combat:
		# adds wall climb mechanic
		if is_on_wall():
			var direction := Input.get_axis("up", "down")
			animated_sprite_2d.play("climbing")
			if direction > 0:
				animated_sprite_2d.flip_v = false
			elif direction < 0: 
				animated_sprite_2d.flip_v = true
			if direction:
				velocity.y = direction * SPEED
			else:
				velocity.y = move_toward(velocity.y, 0, SPEED)
			if Input.is_action_pressed("left") or Input.is_action_pressed("right") and Input.is_action_pressed("jump"):
				direction = Input.get_axis("left", "right")
				wall_direction = direction

				if direction:
					velocity.x = direction * SPEED
					velocity.y = jump()
			elif !is_on_wall():
				animated_sprite_2d.flip_v = false
		# applies gravity and allows player to move around while falling
		elif not is_on_floor() and !is_on_wall():
			velocity += get_gravity() * delta
			var direction := Input.get_axis("left", "right")
			if direction == 0:
				animated_sprite_2d.pause()
			else:
				animated_sprite_2d.play("walking")
			wall_direction = direction

			if direction:
				velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
		# regular ground movement and jump
		else:
			# Handle jump.
			if Input.is_action_pressed("jump") and is_on_floor():
				velocity.y = jump()
			if !is_on_wall() and is_on_floor():
				animated_sprite_2d.flip_v = false

				var direction := Input.get_axis("left", "right")
				if direction == 0:
					animated_sprite_2d.pause()
				else:
					animated_sprite_2d.play("walking")
				if direction > 0: 
					animated_sprite_2d.flip_h = false
				elif direction <0:
					animated_sprite_2d.flip_h = true
				wall_direction = direction
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
func wall_jump():
	pass
##### COMBAT #####

# Player will enter combat and will connect the hit enemy signal to the current
# enemy's "take_hit" function
func enter_combat():
	GvPlayer.in_combat = true
	connect("hit_enemy", Callable(current_enemy, "take_hit"))
	print("Entering combat mode... Player can’t move now.")
	player_camera.zoom_in_on_battle(wall_direction)

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


func _on_hit_box_body_entered(body: Node2D) -> void:
	if !GvPlayer.LeafUpgrade:
		GvPlayer.player_health -= 1
		emit_signal("respawn", global_position)
	else:
		leaf.show()


func _on_hit_box_body_exited(body: Node2D) -> void:
	if GvPlayer.LeafUpgrade:
		leaf.hide()

func in_ant_hill():
	player_camera.zoom_in_underground()
	player_camera.in_underground = true

func leaving_ant_hill():
	player_camera.in_underground = false
	player_camera.return_to_normal()
