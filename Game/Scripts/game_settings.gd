extends Control
@onready var ball_count_slider = $CenterContainer/VBoxContainer/HBoxContainer/BallCountSlider
@onready var balls_label = $CenterContainer/VBoxContainer/HBoxContainer/BallsLabel

func _ready():
	reset_settings()

func reset_settings():
	Manager.gamerulesChanged = false
	ball_count_slider.value = Manager.ball_count
	balls_label.text = "Balls x" + str(ball_count_slider.value)

func _on_ball_count_slider_value_changed(value):
	if Manager.ball_count != value:
		Manager.gamerulesChanged = true
	else:
		Manager.gamerulesChanged = false
	balls_label.text = "Balls x" + str(value)
