class_name ObjectPool
extends Node

@export var poolScene:PackedScene
@export var poolSize:int
var objects:Array[Node2D]
var available:int

func _ready() -> void:
	objects.resize(poolSize)
	for i in range(poolSize):
		objects[i] = poolScene.instantiate()
		objects[i].process_mode = Node.PROCESS_MODE_DISABLED
		objects[i].hide()
		add_child(objects[i])
	available = poolSize

func getFromPool() -> Node2D:
	if available == 0:
		return null
	var obj = objects[0]
	available -= 1
	objects[0] = objects[available]
	objects[available] = null
	if obj:
		obj.show()
		obj.process_mode = Node.PROCESS_MODE_ALWAYS
	return obj

func returnToPool(obj:Node2D) -> void:
	if available < poolSize and obj:
		call_deferred("disableNode",obj)
		obj.hide()
		objects[available] = obj
		available += 1

func disableNode(obj:Node2D) -> void:
	obj.process_mode = Node.PROCESS_MODE_DISABLED

func returnOnSignal(signalName:StringName) -> void:
	for i in range(poolSize):
		objects[i].connect(signalName, returnToPool.bind(objects[i]))
