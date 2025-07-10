extends MotionState

func enter(previous_state_path: String, data := {}) -> void:
	#var input_direction := get_input_direction()
	#update_look_direction(input_direction)
	player.animation_player.play("run")

func physics_update(delta: float) -> void:
	super.physics_update(delta)
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.move_and_slide()
	
	
	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif is_zero_approx(input_direction_x):
		finished.emit(BREAKING)
