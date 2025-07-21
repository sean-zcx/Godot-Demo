extends PlayerState

var crouching_phase: CrouchingPhase

func enter(previous_state_path: String, data := {}) -> void:
	player.mode = player.MODE.MOTION
	player.crouch_shape.disabled = false
	player.stand_shape.disabled = true
	crouching_phase = data["phase"]
	player.velocity.x = 0
	print("[CROUCHING]: ", crouching_phase)

func physics_process(delta: float) -> void:
	player.velocity.x = 0
	
	if !player.is_on_floor():
		finished.emit(FALLING)
		return

	match crouching_phase:
		CrouchingPhase.CROUCHING_DOWN:
			if player.animation_player.current_animation != "crouching_down":
				player.animation_player.play("crouching_down")
				
			if Input.is_action_just_pressed("roll"):
				finished.emit(ROLLING)
				#finished.emit(CROUCH_STABBING)
				return
				
			if not Input.is_action_pressed("move_down"):
				crouching_phase = CrouchingPhase.CROUCHING_UP
		CrouchingPhase.CROUCHING_STILL:
			if player.animation_player.current_animation != "crouching_still":
				player.animation_player.play("crouching_still")
				
			if Input.is_action_just_pressed("roll"):
				finished.emit(ROLLING)
				#finished.emit(CROUCH_STABBING)
				return
				
			if not Input.is_action_pressed("move_down"):
				crouching_phase = CrouchingPhase.CROUCHING_UP
		CrouchingPhase.CROUCHING_UP:
			if player.animation_player.current_animation != "crouching_up":
				player.animation_player.play("crouching_up")
		CrouchingPhase.CROUCHING_DONE:
			finished.emit(IDLE)

			
func on_animation_finished(anim_name):
	if anim_name == "crouching_down":
		print("crouching_down finished")
		crouching_phase = CrouchingPhase.CROUCHING_STILL
		print("[CROUCHING]: CROUCHING_STILL")

	elif anim_name == "crouching_up":
		print("crouching_up finished")
		crouching_phase = CrouchingPhase.CROUCHING_DONE
		print("[CROUCHING]: CROUCHING_DONE")
