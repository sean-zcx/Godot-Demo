extends PlayerState

enum LandingPhase {
	FALLING,
	HIT_GROUND,
	FINISHED,
}

var landing_phase := LandingPhase.FALLING

func enter(previous_state_path: String, data := {}) -> void:
	landing_phase = LandingPhase.FALLING
	player.animation_player.play("falling")

func physics_process(delta: float) -> void:
	var input_direction := player.get_input_direction()
	player.velocity.x = move_toward(player.velocity.x, player.IN_AIR_SPEED * input_direction.x, player.IN_AIR_ACCELECTION * delta)
	player.velocity.y += player.DEFAULE_GRAVITY * delta
	player.move_and_slide()
	
	match landing_phase:
		LandingPhase.FALLING:
			if player.is_on_floor():
				landing_phase = LandingPhase.HIT_GROUND
				player.animation_player.play("hitting_ground")
				player.velocity.x = 0
		LandingPhase.HIT_GROUND:
			if Input.is_action_just_pressed("jump"):
				finished.emit(JUMPING)
		LandingPhase.FINISHED:
			finished.emit(IDLE)

func on_animation_finished(anim_name):
	if anim_name == "hitting_ground":
		print("hitting_ground finished")
		landing_phase = LandingPhase.FINISHED
