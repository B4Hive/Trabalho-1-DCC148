extends Node2D

@onready var timer = $Timer
@onready var enemy = $Enemy
var limit:int = 2 + 3
signal enemyDied

func _ready() -> void:
	timer.one_shot = true
	timer.stop()

func start()->void:
	timer.start(3)

func _on_timer_timeout() -> void:
	#TODO tratar respawn direito... ao invés de size + 2
	if get_children().size() < limit:
		var e = enemy.duplicate()
		add_child(e)
		e.spawn()
		timer.start(3)

func _on_enemy_dead() -> void:
	timer.start(3)
	enemyDied.emit()
