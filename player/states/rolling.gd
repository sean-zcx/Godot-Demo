extends PlayerState

var is_rolling_anim_done: bool
var sign: bool
var is_moving: bool

func enter(previous_state_path: String, data := {}) -> void:
	# disable player look direction
	player.mode = player.MODE.OTHER
	player.crouch_shape.disabled = false
	player.stand_shape.disabled = true
	is_rolling_anim_done = false
	sign = player.look_direction.x < 0
	is_moving = true
	owner.animation_player.play("rolling")

func physics_process(delta: float) -> void:
	if is_moving:
		player.velocity.x = move_toward(-player.ROLL_SPEED if sign else player.ROLL_SPEED, 0, 6000 * delta)
	
	player.move_and_slide()

	var input_direction: Vector2 = player.get_input_direction()

	if !player.is_on_floor():
		finished.emit(FALLING)
		return
	if is_rolling_anim_done:
		if Input.is_action_pressed("move_down"):
			finished.emit(CROUCHING, {"phase": CrouchingPhase.CROUCHING_DOWN})
			return
		else:
			finished.emit(CROUCHING, {"phase": CrouchingPhase.CROUCHING_UP})
			return
		return

func on_animation_finished(anim_name):
	if anim_name == "rolling":
		print("rolling finished")
		is_rolling_anim_done = true

func stop_move():
	print("should stop moving")
	is_moving = false
	player.velocity.x = 0
