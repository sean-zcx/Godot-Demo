class_name Player extends CharacterBody2D

@export var RUN_SPEED:float = 350
@export var RUN_END_SPEED: float = 100
@export var RUN_ACCELECTION:float = 1000
@export var RUN_TURNING_SPEED:float = RUN_ACCELECTION / 10

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var DEFAULE_GRAVITY = ProjectSettings.get_setting('physics/2d/default_gravity')
var last_scale_x = 1
var is_turning = false

func _ready() -> void:
	print("Player ready")

func _physics_process(delta: float) -> void:
	checkFacingDirection()

func checkFacingDirection() -> void:
	var direction_x = Input.get_axis(&"move_left", &"move_right")
	if (!is_zero_approx(direction_x)):
		# flip sprite
		animated_sprite_2d.scale.x = 1 if direction_x < 0 else -1
		# notify turning
		if animated_sprite_2d.scale.x != last_scale_x:
			print("turning happened")
			is_turning = true
		else:
			is_turning = false
			
		last_scale_x = animated_sprite_2d.scale.x
