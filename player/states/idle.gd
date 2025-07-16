extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.x = 0.0
	player.animation_player.play("idle_1")

func physics_process(delta: float) -> void:
	player.velocity.y += player.DEFAULE_GRAVITY * delta
	player.move_and_slide()
	var input_direction_x := Input.get_axis("move_left", "move_right")
	
	if !is_zero_approx(input_direction_x):
		finished.emit(RUNNING)
