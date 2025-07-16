extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.animation_player.play("running")

func physics_process(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = move_toward(player.velocity.x, player.RUN_SPEED * input_direction_x, player.RUN_ACCELECTION * delta)
	player.move_and_slide()
	var init_speed = player.velocity.x
	
	if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		print("released in running")
		finished.emit(RUNNING_END, {"speed": player.velocity.x})
		
	if !is_zero_approx(input_direction_x):
		pass
