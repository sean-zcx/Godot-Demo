extends PlayerState

var last_input_direction_x
var is_turning
var is_running_end_anim_done = false
var is_breaking = false

func enter(previous_state_path: String, data := {}) -> void:
	last_input_direction_x = Input.get_axis("move_left", "move_right")
	is_turning = false
	print("in running, player.is_turning: ", player.is_turning)
	if player.is_turning or is_turning:
		print("playing turning")
		player.animation_player.play("turning")
	else:
		player.animation_player.play("running_begin")

func physics_process(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = move_toward(player.velocity.x, player.RUN_SPEED * input_direction_x, player.RUN_ACCELECTION * delta)
	player.move_and_slide()
	var init_speed = player.velocity.x
	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		#finished.emit(RUNNING_END, {"speed": player.velocity.x})
		is_breaking = true
		player.animation_player.play("running_end")
		player.velocity.x = move_toward(init_speed, 0, player.RUN_ACCELECTION * delta)
	
	if is_running_end_anim_done:
		is_running_end_anim_done = false
		is_breaking = false
		finished.emit(IDLE)
		
	if !is_zero_approx(input_direction_x):
		pass
		#print("btn pressed")
		#finished.emit(RUNNING)	
	# ❗方向改变时，触发 turning 动画
	#if not is_turning and !is_zero_approx(input_direction_x) and sign(input_direction_x) != sign(last_input_direction_x):
		#is_turning = true
		#last_input_direction_x = input_direction_x
		#print("SHOULD PLAY TURNING")
		#player.animation_player.play("turning")

func on_animation_finished(anim_name):
	if anim_name == "running_begin" or  anim_name == "turning":
		print("running_begin finished")
		player.animation_player.play("running")
	if anim_name == "running_end":
		print("running_end finished")
		is_running_end_anim_done = true
