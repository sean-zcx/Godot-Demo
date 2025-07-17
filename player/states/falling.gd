extends PlayerState

enum LandingPhase {
	FALLING,
	HIT_GROUND,
	FINISHED
}

var landing_phase := LandingPhase.FALLING

var is_hitting_ground := false
var is_hitting_ground_done := false

func enter(previous_state_path: String, data := {}) -> void:
	is_hitting_ground = false
	is_hitting_ground_done = false
	landing_phase = LandingPhase.FALLING
	player.animation_player.play("falling")

func physics_process(delta: float) -> void:
	var input_direction := player.get_input_direction()
	player.velocity.x = move_toward(player.velocity.x, player.IN_AIR_SPEED * input_direction.x, player.IN_AIR_ACCELECTION * delta)
	player.velocity.y += player.DEFAULE_GRAVITY * delta
	player.move_and_slide()
	
	match landing_phase:
		LandingPhase.FALLING:
			if player.is_on_floor():
				landing_phase = LandingPhase.HIT_GROUND
				player.animation_player.play("hitting_ground")
				player.velocity.x = 0
		LandingPhase.HIT_GROUND:
			if Input.is_action_just_pressed("jump"):
				finished.emit(JUMPING)
		LandingPhase.FINISHED:
			finished.emit(IDLE)

	## 检测落地，只触发一次
	#if player.is_on_floor() and !is_hitting_ground:
		#is_hitting_ground = true
		#player.animation_player.play("hitting_ground")
		#return  # 这一帧不做后续判断，等待动画完成
	#if is_hitting_ground and !is_hitting_ground_done:
		#player.velocity.x = 0
		#if Input.is_action_just_pressed("jump"):
			#finished.emit(JUMPING)
	## 如果落地且动画已完成
	#if is_hitting_ground and is_hitting_ground_done:
		#finished.emit(IDLE)
	

#func on_animation_finished(anim_name):
	#if anim_name == "hitting_ground":	
		#print("hitting_ground finished")
		#is_hitting_ground_done = true

func on_animation_finished(anim_name):
	if anim_name == "hitting_ground":
		print("hitting_ground finished")
		landing_phase = LandingPhase.FINISHED
