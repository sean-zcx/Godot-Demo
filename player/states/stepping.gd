extends PlayerState

var is_stepping_anim_done: bool
var sign: bool
var is_moving: bool

func enter(previous_state_path: String, data := {}) -> void:
	# disable player look direction
	player.mode = player.MODE.OTHER
	is_stepping_anim_done = false
	sign = player.look_direction.x < 0
	is_moving = true
	owner.animation_player.play("stepping")

func physics_process(delta: float) -> void:
	if is_moving:
		player.velocity.x = move_toward(player.STEP_SPEED if sign else -player.STEP_SPEED, 0, 6000 * delta)

	player.move_and_slide()

	var input_direction: Vector2 = player.get_input_direction()

	if !player.is_on_floor():
		finished.emit(FALLING)
		return
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
		return
	#if input_direction and player.look_direction_changed:
		#print("[idle.gd] detected direction changed ")
		#finished.emit(TURNING)
		#return
	#if input_direction.x:
		#finished.emit(RUNNING)
		#return
	if is_stepping_anim_done:
		finished.emit(IDLE)
		return

func on_animation_finished(anim_name):
	if anim_name == "stepping":
		print("stepping finished")
		is_stepping_anim_done = true

func stop_move():
	print("should stop moving")
	is_moving = false
	player.velocity.x = 0
