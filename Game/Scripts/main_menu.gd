extends Node2D

@onready var menu: Control = $CanvasLayer/Menu
@onready var version_label: Label = $CanvasLayer/Menu/Version
@onready var settings: Control = $CanvasLayer/Settings
@onready var fullscreen_box = $CanvasLayer/Settings/CenterContainer/VBoxContainer/HBoxContainer/CheckBox as CheckBox
@onready var board_select_menu: Control = $CanvasLayer/BoardSelect
@onready var board_select = $CanvasLayer/BoardSelect/CenterContainer/VBoxContainer/HBoxContainer
@onready var transition: Control = $CanvasLayer/Transition

var board_button = preload("res://Nodes/level_button.tscn")

func _ready():
	version_label.text = str(Manager.version)
	transition.black_screen()
	await get_tree().create_timer(0.25).timeout
	transition.play_anim_backwards()
	await get_tree().create_timer(1).timeout
	transition.reset()
	board_select_setup()

func board_select_setup():
	for board in Manager.boards.size():
		var b = board_button.instantiate() as Button
		b.goto_level.connect(on_level_selected)
		b.level = Manager.boards[board][0]
		b.text = Manager.boards[board][1]
		b.icon = ResourceLoader.load(Manager.boards[board][2])
		Manager.curBoard = Manager.boards[board][0]
		board_select.add_child(b)

func _process(delta):
	if Manager.windowMode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		fullscreen_box.button_pressed = true

func _on_check_box_toggled(toggled_on):
	if toggled_on:
		# Fullscreen
		Manager.windowMode = DisplayServer.WINDOW_MODE_FULLSCREEN
	else:
		# Windowed
		Manager.windowMode = DisplayServer.WINDOW_MODE_WINDOWED
	Manager._set_window_mode()

func on_level_selected(level):
	Manager.curBoard = level
	transition.play_anim()
	await get_tree().create_timer(1.0).timeout
	transition.black_screen()
	get_tree().change_scene_to_file(Manager.curBoard)

func _on_play_pressed() -> void:
	board_select_menu.visible = true
	menu.visible = false
func _on_board_select_back_pressed() -> void:
	board_select_menu.visible = false
	menu.visible = true

func _on_settings_pressed():
	settings.visible = true
	menu.visible = false
func _on_settings_back_pressed():
	settings.visible = false
	menu.visible = true

func _on_quit_pressed():
	get_tree().quit()
