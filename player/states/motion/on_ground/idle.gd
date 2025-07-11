extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.x = 0.0
	player.animation_player.play("idle_2")

func physics_process(delta: float) -> void:
	#super.physics_process(delta)
	player.velocity.y += player.gravity * delta
	player.move_and_slide()
	var input_direction_x := Input.get_axis("move_left", "move_right")
	

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif !is_zero_approx(input_direction_x):
		finished.emit(RUNNING)
