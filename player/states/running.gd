extends PlayerState



var running_phase = RunningPhase.RUNNING_BEGIN

func enter(previous_state_path: String, data := {}) -> void:
	player.mode = player.MODE.MOTION
	running_phase = RunningPhase.RUNNING_BEGIN
	print("[RUNNING]: RUNNING_BEGIN")
	player.animation_player.play("running_begin")

func physics_process(delta: float) -> void:
	var input_direction := player.get_input_direction()
	player.velocity.x = move_toward(player.velocity.x, player.RUN_SPEED * input_direction.x, player.RUN_ACCELECTION * delta)
	player.move_and_slide()

	# 转跳状态判断
	if !player.is_on_floor():
		finished.emit(FALLING)
		return
	if Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
		return
	if player.look_direction_changed:
		print("[running.gd] detected direction changed ")
		finished.emit(TURNING)
		return
	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		if running_phase == RunningPhase.RUNNING_BEGIN:
			print("2x ending animation")
			player.animation_player.speed_scale != 2
		player.animation_player.play("running_end_2")
		running_phase = RunningPhase.RUNNING_END
		print("[RUNNING]: RUNNING_END")
	if Input.is_action_just_pressed("step_back"):
		finished.emit(STEPPING)
		return
	if Input.is_action_pressed("move_down"):
		finished.emit(CROUCHING, {"phase": CrouchingPhase.CROUCHING_DOWN})
		return
	match running_phase:
		RunningPhase.RUNNING_BEGIN:
			# do nothing here; wait for animation to finish and switch phase
			pass
		RunningPhase.RUNNING:
			if player.animation_player.current_animation != "running":
				player.animation_player.play("running")
		RunningPhase.RUNNING_END:
			# 中途又按了方向键 → 回到 RUNNING_BEGIN
			if !is_zero_approx(input_direction.x):
				running_phase = RunningPhase.RUNNING_BEGIN
				print("[RUNNING]: RUNNING_BEGIN")
				player.animation_player.play("running_begin")
		RunningPhase.RUNNING_DONE:
			finished.emit(IDLE)

func on_animation_finished(anim_name):
	if anim_name == "running_begin":
		print("running_begin finished")
		running_phase = RunningPhase.RUNNING
		print("[RUNNING]: RUNNING_RUNNING")

	elif anim_name == "running_end_2":
		print("running_end finished")
		running_phase = RunningPhase.RUNNING_DONE
		print("[RUNNING]: RUNNING_DONE")
