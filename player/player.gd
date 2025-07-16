class_name Player extends CharacterBody2D

@export var RUN_SPEED:float = 350
@export var RUN_END_SPEED: float = 100
@export var RUN_ACCELECTION:float = 1000
@export var RUN_TURNING_SPEED:float = RUN_ACCELECTION / 10

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var DEFAULE_GRAVITY = ProjectSettings.get_setting('physics/2d/default_gravity')
enum FACING_DIRECTION{LEFT, RIGHT}

#var direction = Vector2(0, 0):
	#set(value):
		#direction = value
		#if (!is_zero_approx(direction.x)):
			#animated_sprite_2d.scale.x = 1 if direction.x == DIRECTION.LEFT else -1
#var face_direction = -1

	
var last_scale_x  = 1
var is_turning = false


func _ready() -> void:
	print("Player ready")

func _physics_process(delta: float) -> void:
	if not is_zero_approx(velocity.x): 
		if velocity.x < 0.0:
			animated_sprite_2d.scale.x = 1.0
		else:
			animated_sprite_2d.scale.x = -1.0
			
		if sign(last_scale_x) != sign(animated_sprite_2d.scale.x):
			print('player is turning')
			animation_player.play("turning")
		last_scale_x = animated_sprite_2d.scale.x 

func get_movemonet_direction() -> Vector2:
	return Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
