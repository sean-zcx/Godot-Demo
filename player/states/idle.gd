extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.x = 0
	owner.animation_player.play("idle_1")

func physics_process(delta: float) -> void:
	owner.velocity.y += owner.DEFAULE_GRAVITY * delta
	var input_direction: Vector2 = player.get_input_direction()
	owner.move_and_slide()
	
	if input_direction and player.look_direction_changed:
		print("[idle.gd] detected direction changed ")
		finished.emit(TURNING)
		return
	elif input_direction:
		finished.emit(RUNNING_BEGIN)
