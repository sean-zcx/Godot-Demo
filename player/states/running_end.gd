extends PlayerState

var init_speed :float
var is_running_end_anim_done : bool

func enter(previous_state_path: String, data := {}) -> void:
	player.mode = player.MODE.MOTION

	init_speed = data["speed"] / 10
	
	player.animation_player.play("running_end_2")
	#player.animation_player.play("running_end")
	is_running_end_anim_done = false

func on_animation_finished(anim_name):
	if anim_name == "running_end_2":	
		print("running_end finished")
		is_running_end_anim_done = true

func physics_process(delta: float) -> void:
	player.velocity.x = move_toward(init_speed, 0, player.RUN_ACCELECTION * delta)
	var input_direction: Vector2 = player.get_input_direction()
	player.move_and_slide()
	
	if Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif !player.is_on_floor():
		finished.emit(FALLING)
	elif(player.look_direction_changed):
		print("[running_end.gd] detected direction changed ")
		finished.emit(TURNING)
	elif is_running_end_anim_done:
		finished.emit(IDLE)
		return
	elif !is_zero_approx(input_direction.x):
		finished.emit(RUNNING_BEGIN)	
