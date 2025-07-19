extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.mode = player.MODE.MOTION
	player.velocity.y = - player.JUMP_IMPUSE
	player.animation_player.play("jumping")

func physics_process(delta: float) -> void:
	var input_direction := player.get_input_direction()
	player.velocity.x = move_toward(player.velocity.x, player.IN_AIR_SPEED * input_direction.x, player.IN_AIR_ACCELECTION * delta)
	player.velocity.y += player.DEFAULE_GRAVITY * delta
	player.move_and_slide()
	
	if player.velocity.y < 200 and player.velocity.y > -200:
		player.animation_player.play("hang_in_air")
	
	if player.is_on_floor():
		finished.emit(IDLE)
		return
	elif player.velocity.y >= 200:
		finished.emit(FALLING)
		return
