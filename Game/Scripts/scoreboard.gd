extends Panel
@onready var highscore: Label = $ScoreboardVbox/Highscore
@onready var highscore_name: Label = $ScoreboardVbox/HighscoreName
@onready var new_highscore_area: VBoxContainer = $NewHighscoreArea
@onready var new_highscore_name_textEdit: LineEdit = $NewHighscoreArea/NewHighscoreTextEdit

@onready var scoreboard = preload("res://Nodes/scoreboard_vbox.tscn")

var highscore_global: int
var highscore_player_global: String
func _ready() -> void:
	new_highscore_area.visible = false
	
	if Manager.highscore.is_empty():
		highscore.text = "NaN"
		highscore_name.text = "Not set"
		return
	
	highscore_player_global = Manager.highscore[0]
	highscore_global = int(Manager.highscore[1])
	
	highscore.text = str(highscore_global)
	highscore_name.text = str(highscore_player_global)

func _checkScores() -> void:
	if int(highscore_global) >= Manager.score: return
	new_highscore_area.visible = true
	new_highscore_name_textEdit.grab_focus()

func _setHighscore() -> void:
	if new_highscore_name_textEdit.text.is_empty(): return
	
	# set visible highscore
	highscore_name.text = str(new_highscore_name_textEdit.text)
	highscore.text = str(Manager.score)
	
	# set global highscore for session
	Manager.highscore[0] = new_highscore_name_textEdit.text
	Manager.highscore[1] = Manager.score
	$"../Background/HBoxContainer/HSplitContainer/AgainButton".grab_focus()
	new_highscore_area.visible = false

func _on_new_highscore_text_edit_input(event: InputEvent) -> void:
	if event.is_action_released("accept"):
		_setHighscore()
