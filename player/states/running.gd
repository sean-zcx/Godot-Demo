extends PlayerState

@export var RUN_SPEED:float = 300
@export var RUN_ACCELECTION:float = 1000
@export var RUN_TURNING_SPEED:float = RUN_ACCELECTION / 10

func enter(previous_state_path: String, data := {}) -> void:
	owner.jump_count = 0
	player.change_collision_shape('running')
	player.animation_player.play("running")

func physics_process(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	#player.velocity.x = player.speed * input_direction_x
	#player.velocity.y += player.gravity * delta
	#
	#player.velocity.x = move_toward(player.velocity.x, RUN_SPEED * player.direction.x, RUN_ACCELECTION * delta)
	
	
	if not player.is_on_floor():
		#finished.emit(FALLING)
		pass
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif is_zero_approx(input_direction_x):
		#finished.emit(BREAKING)
		finished.emit(IDLE)
	else:
		player.velocity.x = move_toward(player.velocity.x, RUN_SPEED * input_direction_x, RUN_ACCELECTION * delta)
		if abs(player.velocity.x) > RUN_TURNING_SPEED:
			player.animation_player.play("run")
	player.move_and_slide()
