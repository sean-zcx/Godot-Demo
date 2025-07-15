class_name Player extends CharacterBody2D

@export var RUN_SPEED:float = 300
@export var RUN_END_SPEED: float = 10
@export var RUN_ACCELECTION:float = 600
@export var RUN_TURNING_SPEED:float = RUN_ACCELECTION / 10


@export var speed := 300.0
#@export var gravity := 1800.0
@export var gravity := 1800.0

@export var jump_impulse := 700.0

@onready var running_begin_shape: CollisionShape2D = $RunningBeginShape
@onready var running_end_shape: CollisionShape2D = $RunningEndShape
@onready var running_shape: CollisionShape2D = $RunningShape
@onready var idle_shape: CollisionShape2D = $IdleShape
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


var DEFAULE_GRAVITY = ProjectSettings.get_setting('physics/2d/default_gravity')
var shapes

func _ready() -> void:
	print("Player ready")
	shapes = [running_begin_shape, running_end_shape, running_shape, idle_shape]
	#animated_sprite_2d.scale.x = -1
		
func checkFacingDirection() -> void:
	var direction_x = Input.get_axis(&"move_left", &"move_right")
	if (!is_zero_approx(direction_x)):
		animated_sprite_2d.scale.x = -1 if direction_x < 0 else 1
		for shape in shapes:
			shape.position.x = shape.position.x * (-1 if direction_x < 0 else 1)

func _physics_process(delta: float) -> void:
	checkFacingDirection()

func _disable_shapes():
	idle_shape.disabled = true
	running_shape.disabled = true
	running_end_shape.disabled = true
	running_begin_shape.disabled = true

func change_collision_shape(shapeName = 'idle'):
	_disable_shapes()
	match shapeName:
		"idle":
			idle_shape.disabled = false
		"running_begin":
			running_begin_shape.disabled = false
		"running":
			running_shape.disabled = false
		"running_end":
			running_end_shape.disabled = false
