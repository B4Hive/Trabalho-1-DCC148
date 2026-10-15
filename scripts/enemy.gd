extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -600.0

var sprite:AnimatedSprite2D
var direction:int
var trapped:bool

signal dead

func _ready() -> void:
	hide()
	process_mode = Node.PROCESS_MODE_DISABLED
	direction = (randi_range(0,1) * 2) - 1
	trapped = false

func randomizeColor()->void:
	var sprites = get_children()
	sprites.pop_front()
	sprite = sprites.pick_random()
	sprite.show()

func _physics_process(delta: float) -> void:
	var animation:String
	if not trapped:
		if not is_on_floor():
			velocity += get_gravity() * delta
			animation = "jump"
		var jumpRNG = randf()
		if jumpRNG < 0.005 and is_on_floor():
			velocity.y = JUMP_VELOCITY
		if is_on_wall():
			direction *= -1
		if direction:
			velocity.x = direction * SPEED
			if not animation:
				animation = "walk"
			if direction > 0:
				sprite.flip_h = false
			elif direction < 0:
				sprite.flip_h = true
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if not animation:
			animation = "idle"
		sprite.play(animation)
		move_and_slide()
	if trapped:
		sprite.play("trapped")
		rotate(0.01)

func trap(globalPos:Vector2)->void:
	trapped = true
	global_position = globalPos
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, false)

func spawn()->void:
	randomizeColor()
	show()
	process_mode = Node.PROCESS_MODE_ALWAYS

func reset()->void:
	trapped = false
	rotation = 0
	set_collision_layer_value(1, true)
	set_collision_layer_value(2, true)

func death()->void:
	dead.emit()
	queue_free()
