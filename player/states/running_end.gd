extends PlayerState

var done_anim := false
var init_speed :float

func enter(previous_state_path: String, data := {}) -> void:
	done_anim = false
	init_speed = data["speed"] / 10
	if player.is_turning:
		print("playing turning")
		player.animation_player.play("turning")
	else:
		player.animation_player.play("running_end")

func on_animation_finished(anim_name):
	if anim_name == "running_end":
		print("running_end finished")
		done_anim = true
	if anim_name  == "turning":
		finished.emit("running")

func physics_process(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	#TODO: change the speed
	player.velocity.x = move_toward(init_speed, 0, player.RUN_ACCELECTION * delta)
	
	if done_anim:
		finished.emit(IDLE)
	
	#if not player.is_on_floor():
		##finished.emit(FALLING)
		#pass
	#elif Input.is_action_just_pressed("jump"):
		#finished.emit(JUMPING)
	#elif done_anim:
		#finished.emit(IDLE)
	elif !is_zero_approx(input_direction_x):
		finished.emit(RUNNING)	

	player.move_and_slide()
