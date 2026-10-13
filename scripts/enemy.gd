extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -600.0

var direction:int
var trapped:bool

signal dead

func _ready() -> void:
	hide()
	process_mode = Node.PROCESS_MODE_DISABLED
	direction = (randi_range(0,1) * 2) - 1
	trapped = false
	randomizeColor() #TODO replace with random enemy sprite
	#spawn() #TODO spawn handled by enemy spawner instead of called here

func randomizeColor()->void:
	var r = randi_range(0,1)
	var g = randi_range(0,1)
	var b = randi_range(0,1)
	$Sprite2D.set_modulate(Color(r,g,b))

func _physics_process(delta: float) -> void:
	if not trapped:
		if not is_on_floor():
			velocity += get_gravity() * delta
		var jumpRNG = randf()
		if jumpRNG < 0.005 and is_on_floor():
			velocity.y = JUMP_VELOCITY
		if is_on_wall():
			direction *= -1
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		move_and_slide()
	if trapped:
		rotate(0.01)

func trap(globalPos:Vector2)->void:
	trapped = true
	global_position = globalPos
	set_collision_layer_value(1, false)
	set_collision_layer_value(2, false)

func spawn()->void:
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
