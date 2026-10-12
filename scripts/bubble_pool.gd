extends Node

@onready var bubble:Area2D = $Bubble
var bubbles:Array
var poolSize:int = 10
var available:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Fill in the bubbles Array
	for i in range(poolSize):
		var b = bubble.duplicate()
		disableProcess(b)
		add_child(b)
		bubbles.append(b)
	available = poolSize
	# I know the original bubble isn't on the array

func disableProcess(obj:Node2D)->void:
	obj.process_mode = Node.PROCESS_MODE_DISABLED

func getFromPool(dir:Vector2)->Node2D:
	if available:
		var obj = bubbles.pop_front()
		obj.dir = dir
		obj.show()
		obj.process_mode = Node.PROCESS_MODE_ALWAYS
		available -= 1
		return obj
	return null

func returnToPool(obj:Node2D)->void:
	if available < poolSize and obj:
		disableProcess(obj)
		obj.hide()
		bubbles.append(obj)
		available += 1

func _on_bubble_bubble_hit(area:Area2D,obj:Node2D) -> void:
	returnToPool(area)
	print("hit")
