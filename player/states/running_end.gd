extends PlayerState

var init_speed :float
var is_running_end_anim_done : bool
func enter(previous_state_path: String, data := {}) -> void:
	init_speed = data["speed"] / 10	
	player.animation_player.play("running_end_2")
	#player.animation_player.play("running_end")
	is_running_end_anim_done = false

func on_animation_finished(anim_name):
	if anim_name == "running_end_2"  or anim_name == "turning":	
	#if anim_name == "running_end"  or anim_name == "turning":
		print("running_end finished")
		is_running_end_anim_done = true

func physics_process(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = move_toward(init_speed, 0, player.RUN_ACCELECTION * delta)
	player.move_and_slide()
	
	if is_running_end_anim_done:
		finished.emit(IDLE)
		return
	elif !is_zero_approx(input_direction_x):
		finished.emit(RUNNING_BEGIN)	
