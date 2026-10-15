extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -600.0

@onready var sprite = $Sprite2D
@onready var pool = $BubblePool

var touchingEnemy:bool
const maxHP:int = 10
var hp:int
signal playerHP(hp:int)
signal playerDead

func _ready() -> void:
	pool.returnOnSignal("bubblePop")
	hp = maxHP

func _physics_process(delta: float) -> void:
	var animation:String = "idle"
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animation = "jump"
	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			animation = "walk"
		else:
			animation = "jump"
		if direction > 0: sprite.flip_h = false
		if direction < 0: sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	sprite.play(animation)
	move_and_slide()

	var collided_with_enemy := false
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var body := collision.get_collider()
		if body.is_in_group("enemies"):
			collided_with_enemy = true
			if not touchingEnemy:
				touchingEnemy = true
				hp -= 1
				playerHP.emit(hp)
				if hp <= 0:
					playerDead.emit()
			break
	if not collided_with_enemy:
		touchingEnemy = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var dir = Vector2.RIGHT
		if sprite.flip_h:
			dir *= -1
		var b:Area2D = pool.getFromPool()
		if not b == null:
			b.position = position
			b.dir = dir
