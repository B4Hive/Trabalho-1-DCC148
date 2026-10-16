extends Node

var score:int

func _ready() -> void:
	score = 0

func hideUI()->void:
	$TitleLabel.hide()
	$StartButton.hide()
	$EndlessButton.hide()
func showUI()->void:
	$TitleLabel.show()
	#$StartButton.show()
	#$EndlessButton.show()
	# TODO: restart game

func startGame(n:int)->void:
	hideUI()
	score = 0
	$ScoreLabel.text = "Score: " + str(score)
	$HPLabel.text = "HP: " + str($Player.hp)
	$Walls.start()
	$EnemySpawn.start(n)

func _on_start_button_pressed() -> void:
	startGame(9)

func _on_endless_button_pressed() -> void:
	startGame(999)

func _on_enemy_spawn_enemy_died() -> void:
	score += 1
	$ScoreLabel.text = "Score: " + str(score)

func _on_player_player_hp(hp: int) -> void:
	$HPLabel.text = "HP: " + str(hp)

func _on_player_player_dead() -> void:
	$Player.disable()
	showUI()
	$TitleLabel.text = "Defeat"

func _on_enemy_spawn_game_over() -> void:
	showUI()
	$TitleLabel.text = "Victory!"
