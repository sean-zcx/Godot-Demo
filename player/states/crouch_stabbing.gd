extends PlayerState

var is_crouch_stabbing_anim_done: bool
var is_moving: bool
var can_move: bool

func enter(previous_state_path: String, data := {}) -> void:
	# disable player look direction
	player.mode = player.MODE.OTHER
	player.crouch_shape.disabled = false
	player.stand_shape.disabled = true
	is_crouch_stabbing_anim_done = false
	is_moving = false
	owner.animation_player.play("crouch_stabbing")

func physics_process(delta: float) -> void:
	if is_moving:
		var sign = player.look_direction.x < 0
		player.velocity.x = move_toward(-player.CROUCH_STAB_SPEED if sign else player.CROUCH_STAB_SPEED, 0, 30000 * delta)

	player.move_and_slide()

	var input_direction: Vector2 = player.get_input_direction()

	if !player.is_on_floor():
		finished.emit(FALLING)
		return
	if is_crouch_stabbing_anim_done:
		if Input.is_action_pressed("move_down"):
			finished.emit(CROUCHING, {"phase": CrouchingPhase.CROUCHING_DOWN})
			return
		else:
			finished.emit(CROUCHING, {"phase": CrouchingPhase.CROUCHING_UP})
			return
		return

func on_animation_finished(anim_name):
	if anim_name == "crouch_stabbing":
		print("crouch_stabbing finished")
		is_crouch_stabbing_anim_done = true

func set_is_move(v:bool):
	print("should stop moving")
	is_moving = v
	if not is_moving:
		player.velocity.x = 0
