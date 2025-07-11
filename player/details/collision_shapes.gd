class_name CollisionShapes extends Node

const collisionShapePath = {
	fall = {
		position = Vector2(-70.5,-127.5),
		shape = preload('res://player/details/collision_shapes/fall.tres')
	},
	
	idle = {
		position = Vector2(-70,226.5),
		shape = preload('res://player/details/collision_shapes/idle.tres')
	}
	
	#stand =  {
		#position = Vector2(0, -15),
		#shape = preload('res://player/collisionShape/standShape.tres')
	#},
	#run =  {
		#position = Vector2(0, -15),
		#shape = preload('res://player/collisionShape/runShape.tres')
	#},
	#crouch =  {
		#position = Vector2(0, -11),
		#shape = preload('res://player/collisionShape/crouchShape.tres')
	#},
	#slide =  {
		#position = Vector2(0, -6),
		#shape = preload('res://player/collisionShape/slideShape.tres')
	#},
	#wall_climb =  {
		#position = Vector2(0, -18),
		#shape = preload('res://player/collisionShape/wallClimbShape.tres')
	#}
}
