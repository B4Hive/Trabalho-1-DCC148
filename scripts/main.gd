extends Node

var score:int

func _ready() -> void:
	score = 0

func _on_start_button_pressed() -> void:
	$TitleLabel.hide()
	$StartButton.hide()
	$EndlessButton.hide()
	$ScoreLabel.text = "Score: " + str(score)
	$Walls.start()
	$EnemySpawn.start()

func _on_enemy_spawn_enemy_died() -> void:
	score += 1
	$ScoreLabel.text = "Score: " + str(score)
