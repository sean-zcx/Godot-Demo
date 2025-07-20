extends PlayerState



var landing_phase := LandingPhase.FALLING
var listen_to_crouch: bool

func enter(previous_state_path: String, data := {}) -> void:
	player.mode = player.MODE.MOTION
	landing_phase = LandingPhase.FALLING
	listen_to_crouch = false
	player.animation_player.play("falling")

func physics_process(delta: float) -> void:
	var input_direction := player.get_input_direction()
	player.velocity.x = move_toward(player.velocity.x, player.IN_AIR_SPEED * input_direction.x, player.IN_AIR_ACCELECTION * delta)
	player.velocity.y += player.DEFAULE_GRAVITY * delta
	player.move_and_slide()
	
	if listen_to_crouch:
		finished.emit(CROUCHING, {"phase": CrouchingPhase.CROUCHING_STILL})

	
	match landing_phase:
		LandingPhase.FALLING:
			if player.is_on_floor():
				landing_phase = LandingPhase.HIT_GROUND
				player.animation_player.play("hitting_ground")
				player.velocity.x = 0
		LandingPhase.HIT_GROUND:
			if Input.is_action_pressed("move_down"):
				return
			if Input.is_action_just_pressed("jump"):
				finished.emit(JUMPING)
				return
			if Input.is_action_just_pressed("step_back"):
				finished.emit(STEPPING)
				return
		LandingPhase.FINISHED:
			finished.emit(IDLE)

func on_animation_finished(anim_name):
	if anim_name == "hitting_ground":
		print("hitting_ground finished")
		landing_phase = LandingPhase.FINISHED

func change_to_crouch_still():
	if Input.is_action_pressed("move_down"):
		listen_to_crouch = true
	 
