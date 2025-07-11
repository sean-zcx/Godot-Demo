class_name Player extends CharacterBody2D

@export var speed := 300.0
@export var gravity := 1800.0
@export var jump_impulse := 700.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var DEFAULE_GRAVITY = ProjectSettings.get_setting('physics/2d/default_gravity')
const MAX_JUMP_COUNT = 2

#var direction = Vector2(0, 0):
	#set(direction):
		#if (!is_zero_approx(direction.x)):
			#animated_sprite_2d.scale.x = -1 if direction.x < 0 else 1

var jump_count = 0

func _ready() -> void:
	print("Player ready")

func checkFacingDirection() -> void:
	var direction_x = Input.get_axis(&"move_left", &"move_right")
	if (!is_zero_approx(direction_x)):
			animated_sprite_2d.scale.x = -1 if direction_x < 0 else 1

func _physics_process(delta: float) -> void:
	checkFacingDirection()
