extends Node2D

@onready var timer = $Timer
@onready var enemy = $Enemy

# Child limit: 1 original enemy + 1 timer + max amount of enemies on screen
var onScreenLimit:int = 2 + 3

signal enemyDied
signal gameOver

# For endless mode shenanigans and proper endgame
var maxEnemies:int

func _ready() -> void:
	timer.one_shot = true
	timer.stop()

func start(m:int)->void:
	if m:
		maxEnemies = m
	else:
		maxEnemies = 9999
	timer.start(3)

func _on_timer_timeout() -> void:
	if get_children().size() < onScreenLimit:
		var e = enemy.duplicate()
		add_child(e)
		e.spawn()
		maxEnemies -= 1
		if maxEnemies > 0:
			timer.start(3)

func _on_enemy_dead() -> void:
	enemyDied.emit()
	if maxEnemies > 0:
		timer.start(3)
	else:
		gameOver.emit()
