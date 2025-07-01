extends Node2D

var fade_speed = 3.0
var sprite: AnimatedSprite2D

func _ready():
	sprite = $AnimatedSprite2D

func _process(delta):
	sprite.modulate.a -= fade_speed * delta
	if sprite.modulate.a <= 0:
		queue_free()

func setup(sprite_frames, animation_name, frame, position, flip_h, modulate_color):
	sprite.sprite_frames = sprite_frames
	sprite.animation = animation_name
	sprite.frame = frame
	sprite.flip_h = flip_h
	sprite.modulate = modulate_color
	sprite.pause()  # 残影不继续播放动画
	self.position = position
