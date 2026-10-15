extends Area2D

var speed:float = 200
@export var dir:Vector2
signal bubblePop
var target

@onready var sprite = $Sprite2D
var animScale:float = 0.01

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = null
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(_delta: float) -> void:
	bubbleAnimation()

func bubbleAnimation()->void:
	sprite.scale.x += animScale
	sprite.scale.y += animScale
	if sprite.scale.x <= 2:
		animScale *= -1
	if sprite.scale.x >= 2.5:
		animScale *= -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if dir and not target:
		translate(dir.normalized() * speed * delta)
	if not get_viewport_rect().has_point(position):
		bubblePop.emit()

func _on_body_entered(body: Node2D) -> void:
	if body.is_class("CharacterBody2D") and not target and not body.name == "Player":
		if not body.trapped:
			target = body
			target.trap(global_position)
			#set_collision_layer_value(1, true)
			set_collision_mask_value(1, true)
	if target and target != body:
		if body.get_name() == "Player":
			target.death()
		else:
			target.reset()
		bubblePop.emit()
