extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.mode = player.MODE.MOTION
	owner.animation_player.play("idle_1")

func physics_process(delta: float) -> void:
	owner.velocity.y += owner.DEFAULE_GRAVITY * delta
	player.velocity.x = move_toward(player.velocity.x, 0, player.RUN_ACCELECTION * 2 * delta)

	var input_direction: Vector2 = player.get_input_direction()
	owner.move_and_slide()
	
	if !player.is_on_floor():
		finished.emit(FALLING)
		return
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
		return
	if input_direction and player.look_direction_changed:
		print("[idle.gd] detected direction changed ")
		finished.emit(TURNING)
		return
	if input_direction.x:
		finished.emit(RUNNING)
		return
	if Input.is_action_just_pressed("step_back"):
		finished.emit(STEPPING)
		return


#func on_animation_finished(anim_name):
	#if anim_name == "stepping_back":
		#print("stepping_back finished")
		#player.animation_player.play("idle_1")
