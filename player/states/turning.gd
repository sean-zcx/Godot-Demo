extends PlayerState

var is_turning_done = false
func enter(previous_state_path: String, data := {}) -> void:
	player.mode = player.MODE.MOTION

	player.animation_player.play("turning")
	is_turning_done = false

func physics_process(delta: float) -> void:
	var input_direction := player.get_input_direction()
	player.velocity.x = move_toward(player.velocity.x, player.RUN_SPEED * input_direction.x, player.RUN_ACCELECTION * delta)
	player.move_and_slide()
	
	if Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif !player.is_on_floor():
		finished.emit(FALLING)
	elif is_turning_done:
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			finished.emit(RUNNING)
		else:
			finished.emit(IDLE)
	else:
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			player.animation_player.speed_scale *= 0.9
			#pass
		else:
			player.animation_player.speed_scale *= 1.2
		

func on_animation_finished(anim_name):
	if anim_name == "turning":	
		#print("turning finished")
		is_turning_done = true
