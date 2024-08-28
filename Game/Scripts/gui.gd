extends Control

@onready var score_text = $ScoreText
@onready var balls_left_text = $BallsLeftText

signal clickArea

func _ready() -> void:
	score_text.text = str(Manager.score)
	balls_left_text.text = str(Manager.balls_left)

func _process(delta: float) -> void:
	score_text.text = "Score: " + str(Manager.score)
	balls_left_text.text = "Balls: "+str(Manager.balls_left)
	
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
