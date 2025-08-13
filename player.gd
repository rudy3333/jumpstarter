extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_JUMPS = 2

const DASH_SPEED = 900.0
const DASH_TIME = 0.2 # seconds
const DASH_COOLDOWN = 0.5 # seconds

var jumps_done = 0
var dash_timer = 0.0
var dash_cooldown_timer = 0.0
var dash_direction = 0

func _physics_process(delta: float) -> void:
	# timers
	if dash_timer > 0:
		dash_timer -= delta
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta

	# gravity (only if not dashing vertically)
	if not is_on_floor():
		velocity += get_gravity() * delta

	# reset jumps on floor
	if is_on_floor():
		jumps_done = 0

	# jumping
	if Input.is_action_just_pressed("jump") and jumps_done < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jumps_done += 1

	# dashing
	if Input.is_action_just_pressed("dash") and dash_cooldown_timer <= 0:
		var move_dir = Input.get_axis("left", "right")
		if move_dir != 0:
			dash_direction = move_dir
			dash_timer = DASH_TIME
			dash_cooldown_timer = DASH_COOLDOWN

	# movement
	var direction := Input.get_axis("left", "right")
	if dash_timer > 0:
		velocity.x = dash_direction * DASH_SPEED
	else:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
