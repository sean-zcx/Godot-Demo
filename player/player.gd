class_name Player extends CharacterBody2D

@export var speed := 150.0
@export var gravity := 1800.0
@export var jump_impulse := 700.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal direction_changed(new_direction: Vector2)

var look_direction := Vector2.RIGHT:
	set(value):
		look_direction = value
		set_look_direction(value)

func set_look_direction(value: Vector2) -> void:
	print('direction_changed Changed')
	direction_changed.emit(value)


func _on_direction_changed(new_direction: Vector2) -> void:
	print("Should flip")
	animated_sprite_2d.scale.x *= -1
