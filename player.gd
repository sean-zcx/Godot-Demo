extends CharacterBody2D


const RUN_SPEED := 100.0
const JUMP_VELOCITY := -350
var gravity = ProjectSettings.get("physics/2d/default_gravity") as float

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var ghost_scene: PackedScene
var ghost_interval = 0.05
var ghost_timer = 0.0

@onready var anim_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * RUN_SPEED
	velocity.y += gravity * delta
	
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
	
	if is_on_floor():
		if is_zero_approx(direction):
			animation_player.play("idle")
		else:
			animation_player.play("walk")
	else:
		if velocity.y < -100:
			
			animation_player.play("jump")   
			#sprite_2d.texture = preload("res://frame_37.png")
		elif velocity.y >= -100 and velocity.y <= 100:
			animation_player.play("stay_in_air") 
		else:
			animation_player.play("fall")
	if not is_zero_approx(direction):
		animated_sprite_2d.flip_h = direction < 0
	move_and_slide()
	
	var is_moving = velocity.length() > 0
	
	if is_moving:
		ghost_timer -= delta
		if ghost_timer <= 0:
			spawn_ghost()
			ghost_timer = ghost_interval

func spawn_ghost():
	var ghost = ghost_scene.instantiate()
	get_parent().add_child(ghost)

	ghost.setup(
		anim_sprite.sprite_frames,
		anim_sprite.animation,
		anim_sprite.frame,
		global_position,
		anim_sprite.flip_h,
		Color(92,92,255,0.3)
	)
