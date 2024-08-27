extends Node2D

@onready var settings: Control = $CanvasLayer/Settings
@onready var fullscreen_box = $CanvasLayer/Settings/CenterContainer/VBoxContainer/HBoxContainer/CheckBox as CheckBox
@onready var board_select = $CanvasLayer/BoardSelect/CenterContainer/HBoxContainer

var board_button = preload("res://Nodes/level_button.tscn")

func _ready():
	var l1 = board_button.instantiate() as Button
	l1.text = "HI!!!!"
	board_select.add_child(l1)


func _process(delta):
	if Manager.windowMode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		fullscreen_box.button_pressed = true

func _on_back_pressed():
	settings.visible = false

func _on_check_box_toggled(toggled_on):
	if toggled_on:
		# Fullscreen
		Manager.windowMode = DisplayServer.WINDOW_MODE_FULLSCREEN
	else:
		# Windowed
		Manager.windowMode = DisplayServer.WINDOW_MODE_WINDOWED
	Manager._set_window_mode()



func _on_play_pressed():
	get_tree().change_scene_to_file(Manager.curBoard)

func _on_settings_pressed():
	settings.visible = true

func _on_quit_pressed():
	get_tree().quit()
