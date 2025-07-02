extends CharacterBody2D

const WALK_SPEED = 100.0
const ACCELERATION_SPEED = WALK_SPEED * 6.0
const JUMP_VELOCITY = -500.0
## Maximum speed at which the player can fall.
const TERMINAL_VELOCITY = 700

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var platform_detector := $PlatformDetector as RayCast2D
var gravity: int = ProjectSettings.get("physics/2d/default_gravity")
@onready var camera := $Camera as Camera2D

var _double_jump_charged := false

#@export var ghost_scene: PackedScene
#var ghost_interval = 0.05
#var ghost_timer = 0.0

#@onready var anim_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if is_on_floor():
		_double_jump_charged = true
	if Input.is_action_just_pressed("jump"):
		try_jump()
	elif Input.is_action_just_released("jump") and velocity.y < 0.0:
		# The player let go of jump early, reduce vertical momentum.
		velocity.y *= 0.6
	# Fall.
	velocity.y = minf(TERMINAL_VELOCITY, velocity.y + gravity * delta)
	
	

	var direction := Input.get_axis("move_left" , "move_right" ) * WALK_SPEED
	velocity.x = move_toward(velocity.x, direction, ACCELERATION_SPEED * delta)

	if not is_zero_approx(velocity.x):
		if velocity.x > 0.0:
			animated_sprite_2d.scale.x = 1.0
		else:
			animated_sprite_2d.scale.x = -1.0
		
	# 统一处理动画播放逻辑
	play_correct_animation()
	floor_stop_on_slope = not platform_detector.is_colliding()
	move_and_slide()
	
	
	#var direction := Input.get_axis("move_left", "move_right")
	#velocity.x = direction * RUN_SPEED
	#velocity.y += gravity * delta
	
	#
	#if is_on_floor() and Input.is_action_just_pressed("jump"):
			#velocity.y = JUMP_VELOCITY
	#
	#if is_on_floor():
		#if is_zero_approx(direction):
			#animation_player.play("idle")
		#else:
			#animation_player.play("walk")
	#else:
		#if velocity.y < -100:
			#
			#animation_player.play("jump")   
		#elif velocity.y >= -100 and velocity.y <= 100:
			#animation_player.play("stay_in_air") 
		#else:
			#animation_player.play("fall")
	#if not is_zero_approx(direction):
		#animated_sprite_2d.flip_h = direction < 0
	#move_and_slide()
	#
	#var is_moving = velocity.length() > 0
	#
	##if is_moving:
		##ghost_timer -= delta
		##if ghost_timer <= 0:
			##spawn_ghost()
			##ghost_timer = ghost_interval

#func spawn_ghost():
	#var ghost = ghost_scene.instantiate()
	#get_parent().add_child(ghost)
#
	#ghost.setup(
		#anim_sprite.sprite_frames,
		#anim_sprite.animation,
		#anim_sprite.frame,
		#global_position,
		#anim_sprite.flip_h,
		#Color(1,1,1, 0.5)
	#)
	
func try_jump() -> void:
	if is_on_floor():
		#jump_sound.pitch_scale = 1.0
		pass
	elif _double_jump_charged:
		_double_jump_charged = false
		velocity.x *= 2.5
		#jump_sound.pitch_scale = 1.5
	else:
		return
	velocity.y = JUMP_VELOCITY
	#jump_sound.play()


func play_correct_animation() -> void:
	if not is_on_floor():
		if velocity.y < -100:
			animation_player.play("jump")
		elif velocity.y > 100:
			animation_player.play("fall")
		else:
			animation_player.play("stay_in_air")
	else:
		if not is_zero_approx(velocity.x):
			animation_player.play("walk")
		else:
			animation_player.play("idle")
