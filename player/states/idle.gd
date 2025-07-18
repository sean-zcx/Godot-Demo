extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.mode = player.MODE.MOTION
	owner.animation_player.play("idle_1")

func physics_process(delta: float) -> void:
	owner.velocity.y += owner.DEFAULE_GRAVITY * delta
	player.velocity.x = move_toward(player.velocity.x , 0, player.RUN_ACCELECTION * 2 * delta)

	var input_direction: Vector2 = player.get_input_direction()
	owner.move_and_slide()
	
	if !player.is_on_floor():
		finished.emit(FALLING)
	
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	if input_direction and player.look_direction_changed:
		print("[idle.gd] detected direction changed ")
		finished.emit(TURNING)
		return
	elif input_direction.x:
		finished.emit(RUNNING)
