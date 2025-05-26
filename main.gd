extends Node2D

var best_time = 0
var timer_seconds = 0.0
var is_alive = false

@onready var game_over_panel = $"GameOver Panel"

func _ready():
	if FileAccess.file_exists("user://best_time.save"):
		var file = FileAccess.open("user://best_time.save", FileAccess.READ)
		best_time = file.get_line().to_int()
		file.close()

	var minutes = best_time / 60
	var seconds = best_time % 60
	$"Start Panel"/BestTimeLabel.text = "Melhor tempo: %02d:%02d" % [minutes, seconds]

	$"Start Panel"/StartButton.pressed.connect(start_game)
	$"GameOver Panel/RetryButton".pressed.connect(restart_game)

func save_best_time():
	if int(timer_seconds) > best_time:
		best_time = int(timer_seconds)
		var file = FileAccess.open("user://best_time.save", FileAccess.WRITE)
		file.store_line(str(best_time))
		file.close()

func on_player_died():
	is_alive = false
	save_best_time()
	$TimeLabel.visible = false
	game_over_panel.visible = true
	
	var total_time = int(timer_seconds)
	var current_minutes = total_time / 60
	var current_seconds = total_time % 60
	$"GameOver Panel/TimeLabel".text = "Tempo atual: %02d:%02d" % [current_minutes, current_seconds]

	var best_minutes = best_time / 60
	var best_seconds = best_time % 60
	$"GameOver Panel/BestTimeLabel".text = "Melhor tempo: %02d:%02d" % [best_minutes, best_seconds]

func _process(delta):
	if is_alive:
		timer_seconds += delta
		var total_time = int(timer_seconds)
		var minutes = total_time / 60
		var seconds = total_time % 60
		$TimeLabel.text = "Tempo: %02d:%02d" % [minutes, seconds]

func start_game():
	$"Start Panel".visible = false
	is_alive = true
	$EnemySpawner

func restart_game():
	get_tree().reload_current_scene()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if $Player:
			print("morri")
			$Player.die()
