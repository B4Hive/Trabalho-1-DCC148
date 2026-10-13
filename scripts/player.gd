extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0

@onready var sprite = $Sprite2D
@onready var pool = $BubblePool

func _ready() -> void:
	pool.returnOnSignal("bubblePop")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		# TODO: change sprite for this to be visible
		if direction > 0: sprite.flip_h = false
		if direction < 0: sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var dir = Vector2.RIGHT
		if sprite.flip_h:
			dir *= -1
		var b:Area2D = pool.getFromPool()
		if not b == null:
			b.position = position
			b.dir = dir
