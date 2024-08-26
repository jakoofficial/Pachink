extends Node2D

@onready var settings: Control = $CanvasLayer/Settings
@onready var level: String = "res://Scenes/board.tscn"
@onready var fullscreen_box = $CanvasLayer/Settings/CenterContainer/VBoxContainer/HBoxContainer/CheckBox as CheckBox

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
	get_tree().change_scene_to_file(level)

func _on_settings_pressed():
	settings.visible = true

func _on_quit_pressed():
	get_tree().quit()
