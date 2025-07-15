extends PlayerState



func enter(previous_state_path: String, data := {}) -> void:
	#owner.jump_count = 0
	player.change_collision_shape('running_begin')
	player.animation_player.play("running_begin")
	#player.animation_player.animation_finished.connect(on_animation_finished)

func physics_process(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = move_toward(player.velocity.x, player.RUN_SPEED * input_direction_x, player.RUN_ACCELECTION * delta)
	
	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		finished.emit(RUNNING_END)
	if not player.is_on_floor():
		#finished.emit(FALLING)
		pass
	#elif Input.is_action_just_pressed("jump"):
		#finished.emit(JUMPING)
	
	#elif is_zero_approx(input_direction_x):
		#finished.emit(IDLE)
		

	player.move_and_slide()


func on_animation_finished(anim_name):
	if anim_name == "running_begin":
		print("running_begin finished")
		player.change_collision_shape('running')
		player.animation_player.play("running")
