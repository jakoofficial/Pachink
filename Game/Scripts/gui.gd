extends Control

@onready var score_text = $ScoreText
@onready var balls_left_text = $BallsLeftText
@onready var game_over = $GameOver
@onready var game_over_box = $GameOver/Background
@onready var final_score_label = $GameOver/Background/FinalScoreLabel
@onready var animation = $AnimationPlayer
@onready var transition: Control = $"../Transition"
@onready var end_effect_right = $GameOver/Background/EndEffect_Right
@onready var end_effect_left = $GameOver/Background/EndEffect_Left
@onready var stars_collected = $GameOver/Background/StarsCollected
@onready var balls: Node2D = $"../../Balls"

var game_over_anim_done = false
var can_emit_effect = false

func _ready() -> void:
	score_text.text = str(Manager.score)
	balls_left_text.text = str(Manager.balls_left)
	game_over.visible = false
	%BallLocator.visible = false
	$"%Tutorial".visible = true
	$TutAnims.play("Tutorial")

func _process(delta: float) -> void:
	score_text.text = "Score: " + str(Manager.score)
	balls_left_text.text = "Balls: "+str(Manager.balls_left)
	%BallLocator.position.x = Manager.ballLocation.x
	
	if Manager.balls_left < Manager.ball_count:
		$"%Tutorial".visible = false
	
	if Input.is_action_pressed("quit") and !Manager.gameOver:
		$PauseMenu/CenterContainer/Panel/VBoxContainer/PauseBackButton2.grab_focus()
		Manager.is_paused = true
	
	if Manager.ballLocation.y < 0:
		%BallLocator.visible = true
	else:
		%BallLocator.visible = false
	
	if Manager.balls_left == 0 and not Manager.gameOver and balls.get_children().size() <= 0:
		Manager.gameOver = true
	
	if Manager.gameOver:
		var starParentNode = $"../../Stars"
		
		for starChild in starParentNode.get_children():
			starChild.tween.kill()
			starChild.free()
		get_tree().paused = true
		game_over.visible = true
		$PauseButton.visible = false
		final_score_label.text = "Final score: "+str(Manager.score)
		Manager.collectedStarsTotal += Manager.collectedStarsCurLevel
		
		if not game_over_anim_done:
			can_emit_effect = true
			if %GameOver.has_node("%Scoreboard"):
				%Scoreboard.visible = false
			animation.play("GameOver")
			game_over_anim_done = true
			$GameOver/Background/HBoxContainer/HSplitContainer/AgainButton.grab_focus()
		else:
			if %GameOver.has_node("%Scoreboard"):
				%Scoreboard.visible = true
	
	if !Manager.gameOver:
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

func play_end_effect():
	if can_emit_effect:
		end_effect_right.emitting = true
		end_effect_left.emitting = true

func _on_pause_back_button_pressed():
	Manager.is_paused = false
func _on_pause_button_pressed():
	$GameOver/Background/HBoxContainer/HSplitContainer/AgainButton.grab_focus()
	Manager.is_paused = true
	
func _on_pause_restart_button_pressed():
	get_tree().paused = false
	Manager.is_paused = false
	Manager.reset()
	get_tree().change_scene_to_file(Manager.curBoard)
	
func _on_pause_menu_button_pressed():
	transition.play_anim()
	await get_tree().create_timer(1.0).timeout
	transition.black_screen()
	Manager.reset()
	Manager.is_paused = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

# GameOver
func _on_mainmenu_button_pressed():
	transition.play_anim()
	await get_tree().create_timer(1.0).timeout
	transition.black_screen()
	
	get_tree().paused = false
	Manager.is_paused = false
	Manager.reset()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_again_button_pressed():
	get_tree().paused = false
	Manager.is_paused = false
	can_emit_effect = false
	
	for c in stars_collected.get_children():
		c.visible = false
	
	if %GameOver.has_node("%Scoreboard"):
		$"%Scoreboard".queue_free()
	
	animation.play_backwards("GameOver")
	await get_tree().create_timer(1.45).timeout
	animation.play("RESET")
	Manager.reset()
	get_tree().change_scene_to_file(Manager.curBoard)

func _on_end_effect_finished():
	can_emit_effect = false

func _on_clickable_area_mouse_entered() -> void:
	Manager.mouseOverSpawn = true

func _on_clickable_area_mouse_exited() -> void:
	Manager.mouseOverSpawn = false
