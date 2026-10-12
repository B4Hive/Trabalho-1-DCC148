extends Area2D

var speed:float = 200
@export var dir:Vector2
signal bubbleHit
var target:Node2D
signal targetPos

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = null

func _process(_delta: float) -> void:
	if target:
		targetPos.emit(position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if dir:
		translate(dir.normalized() * speed * delta)
	if not get_viewport_rect().has_point(position):
		bubbleHit.emit(self,null)

func _on_area_entered(area: Node2D) -> void:
	bubbleHit.emit(self,area)
