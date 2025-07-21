class_name PlayerState extends State

const IDLE = "Idle"
const RUNNING = "Running"
const TURNING = "Turning"
const JUMPING = "Jumping"
const FALLING = "Falling"
const STEPPING = "Stepping"
const CROUCHING = "Crouching"
const ROLLING = "Rolling"
const CROUCH_STABBING = "CrouchStabbing"


enum RunningPhase {
	RUNNING_BEGIN,
	RUNNING,
	RUNNING_END,
	RUNNING_DONE,
}

enum CrouchingPhase {
	CROUCHING_DOWN,
	CROUCHING_STILL,
	CROUCHING_UP,
	CROUCHING_DONE,
}

enum LandingPhase {
	FALLING,
	HIT_GROUND,
	FINISHED,
}

var player: Player


func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
