extends Node2D

@onready var plataform:StaticBody2D = $Platform

func start() -> void:
	placePlatforms(532)
	placePlatforms(364)
	placePlatforms(196)

func placePlatforms(y:float)->void:
	var pos:int
	var plat:Array
	for i in range(9):
		plat.append(1)
	pos = randi_range(0,7)
	plat[pos] = 0
	plat[pos+1] = 0
	for i in range(9):
		if plat[i] == 1:
			var p = plataform.duplicate()
			add_child(p)
			p.show()
			p.position.y = y
			p.position.x = 320 + (80 * i)
