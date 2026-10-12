extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -600.0

var direction:int

func _ready() -> void:
	direction = (randi_range(0,1) * 2) - 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	var jumpRNG = randf()
	if jumpRNG < 0.005 and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Handle direction
	if is_on_wall():
		direction *= -1
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
