class_name Player extends CharacterBody2D

@export var RUN_SPEED:float = 350
@export var RUN_END_SPEED: float = 100
@export var RUN_ACCELECTION:float = 1000
@export var RUN_TURNING_SPEED:float = RUN_ACCELECTION / 10

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var DEFAULE_GRAVITY = ProjectSettings.get_setting('physics/2d/default_gravity')
enum FACING_DIRECTION{LEFT, RIGHT}

var look_direction : Vector2
var look_direction_changed = false


func _ready() -> void:
	print("Player ready")
	look_direction = Vector2.LEFT

func _physics_process(delta: float) -> void:
	var direction: Vector2 = get_input_direction()
	if direction.x and look_direction.x !=  direction.x:
		
		print("[player.dg] look_direction changed")
		look_direction_changed = true
		look_direction.x = direction.x
		
		if  direction.x > 0:
			animated_sprite_2d.scale.x = -1
		else:
			animated_sprite_2d.scale.x = 1
	else:
		look_direction_changed = false

func get_input_direction() -> Vector2:
	return Vector2(
			Input.get_axis(&"move_left", &"move_right"),
			Input.get_axis(&"move_up", &"move_down")
	)
