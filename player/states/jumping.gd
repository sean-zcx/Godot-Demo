extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.y = -player.jump_impulse
	player.animation_player.play("jump")

func physics_process(delta: float) -> void:
	#super.physics_process(delta)
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.move_and_slide()
	
	if player.velocity.y < 100 and player.velocity.y > -200:
		player.animation_player.play("stay_in_air")

	if player.velocity.y >= 100:
		#finished.emit(FALLING)
		pass
