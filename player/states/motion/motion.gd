class_name MotionState extends PlayerState

func handle_input(event: InputEvent) -> void:
	#if event.is_action_pressed("simulate_damage"):
		#finished.emit("stagger")
	pass


func get_input_direction() -> Vector2:
	return Vector2(
			Input.get_axis(&"move_left", &"move_right"),
			Input.get_axis(&"move_up", &"move_down")
	)


func update_look_direction(direction: Vector2) -> void:
	if direction and owner.look_direction != direction:
		owner.look_direction = direction


func physics_update(delta: float) -> void:
	var input_direction := get_input_direction()
	update_look_direction(input_direction)
