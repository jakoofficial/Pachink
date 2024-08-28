extends Control

@onready var score_text = $ScoreText
@onready var balls_left_text = $BallsLeftText
@onready var game_over = $GameOver
@onready var game_over_box = $GameOver/Background
@onready var final_score_label = $GameOver/Background/FinalScoreLabel
@onready var animation = $AnimationPlayer

var game_over_anim_done = false

signal clickArea

func _ready() -> void:
	score_text.text = str(Manager.score)
	balls_left_text.text = str(Manager.balls_left)
	game_over.visible = false

func _process(delta: float) -> void:
	score_text.text = "Score: " + str(Manager.score)
	balls_left_text.text = "Balls: "+str(Manager.balls_left)
	
	if Manager.gameOver:
		game_over.visible = true
		$PauseButton.visible = false
		final_score_label.text = "Final score: "+str(Manager.score)
		if not game_over_anim_done:
			animation.play("GameOver")
			game_over_anim_done = true
		else:
			#Wobble
			pass
	
	if Manager.is_paused:
		$PauseMenu.visible = true
		get_tree().paused = true
		$ClickableArea.visible = false
		$PauseButton.visible = false
	else:
		$PauseMenu.visible = false
		get_tree().paused = false
		$PauseButton.visible = true
		$ClickableArea.visible = true

func _on_pause_back_button_pressed():
	Manager.is_paused = false
func _on_pause_button_pressed():
	Manager.is_paused = true
	
func _on_pause_menu_button_pressed():
	Manager.reset()
	Manager.is_paused = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_clickable_area_button_up():
	emit_signal("clickArea")

# GameOver
func _on_mainmenu_button_pressed():
	Manager.reset()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_again_button_pressed():
	Manager.reset()
	Manager.is_paused = false
	get_tree().paused = false
	animation.play_backwards("GameOver")
	await get_tree().create_timer(1.45).timeout
	animation.play("RESET")
	get_tree().change_scene_to_file(Manager.curBoard)
