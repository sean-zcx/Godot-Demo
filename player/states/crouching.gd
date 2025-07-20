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

	if crouching_phase == CrouchingPhase.CROUCHING_STILL and Input.is_action_just_pressed("roll"):
		print("Should move to rolling state")
		return
	match crouching_phase:
		CrouchingPhase.CROUCHING_DOWN:
			if player.animation_player.current_animation != "crouching_down":
				player.animation_player.play("crouching_down")
			if not Input.is_action_pressed("move_down"):
				player.animation_player.play("crouching_up")
				crouching_phase = CrouchingPhase.CROUCHING_UP
		CrouchingPhase.CROUCHING_STILL:
			if player.animation_player.current_animation != "crouching_still":
				player.animation_player.play("crouching_still")
			if not Input.is_action_pressed("move_down"):
				player.animation_player.play("crouching_up")
				crouching_phase = CrouchingPhase.CROUCHING_UP
		CrouchingPhase.CROUCHING_UP:
			pass
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
