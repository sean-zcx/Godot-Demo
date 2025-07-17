extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	#var input_direction := player.get_input_direction()
	#player.update_look_direction(input_direction)
	player.animation_player.play("running")

func physics_process(delta: float) -> void:
	var input_direction :=player. get_input_direction()
	#player.update_look_direction(input_direction)
	player.velocity.x = move_toward(player.velocity.x, player.RUN_SPEED * input_direction.x, player.RUN_ACCELECTION * delta)
	player.move_and_slide()
	var init_speed = player.velocity.x
	
	if(player.look_direction_changed):
		print("[running.gd] detected direction changed ")
		finished.emit(TURNING)
	elif Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		print("released in running")
		finished.emit(RUNNING_END, {"speed": player.velocity.x})
		
	elif !is_zero_approx(input_direction.x):
		pass
