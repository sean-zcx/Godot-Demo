extends PlayerState

var is_running_begin_anim_done : bool

func enter(previous_state_path: String, data := {}) -> void:	
	player.animation_player.play("running_begin")
	is_running_begin_anim_done = false

func physics_process(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = move_toward(player.velocity.x, player.RUN_SPEED * input_direction_x, player.RUN_ACCELECTION * delta)
	player.move_and_slide()
	
	if is_running_begin_anim_done :
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			finished.emit(RUNNING)
		else:
			finished.emit(RUNNING_END, {"speed": player.velocity.x})
			#finished.emit(IDLE)
		
	elif Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right"):
		# 动画还没放完就松开，等待动画结束时根据输入判断
		print("released in running begin")
			
func on_animation_finished(anim_name):
	if anim_name == "running_begin"  or anim_name == "turning":
		print("running_begin animation finished")
		is_running_begin_anim_done = true
