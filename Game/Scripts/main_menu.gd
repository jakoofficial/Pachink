extends Node2D

@onready var menu: Control = $CanvasLayer/Menu
@onready var version_label: Label = $CanvasLayer/Menu/Version
@onready var settings: Control = $CanvasLayer/Settings
@onready var fullscreen_box = $CanvasLayer/Settings/CenterContainer/VBoxContainer/HBoxContainer/CheckBox as CheckBox

@onready var board_select_menu: Control = $CanvasLayer/BoardSelect
@onready var board_select = $CanvasLayer/BoardSelect/CenterContainer/VBoxContainer/HBoxContainer
@onready var game_settings = $CanvasLayer/GameSettings

@onready var transition: Control = $CanvasLayer/Transition
@onready var confirm_box: Control = $CanvasLayer/GameSettings/ConfirmBox

var board_button = preload("res://Nodes/level_button.tscn")
var mouse_over:bool = false

func _ready():
	version_label.text = str(Manager.version)
	transition.black_screen()
	await get_tree().create_timer(0.25).timeout
	transition.play_anim_backwards()
	await get_tree().create_timer(1).timeout
	transition.reset()
	board_select_setup()
	%Play.grab_focus()

func board_select_setup():
	var boardButtons = []
	for board in Manager.boards.size():
		var b = board_button.instantiate() as Button
		b.goto_level.connect(on_level_selected)
		b.level = Manager.boards[board][0]
		b.text = Manager.boards[board][1]
		b.icon = ResourceLoader.load(Manager.boards[board][2])
		boardButtons.append(b)
		Manager.curBoard = Manager.boards[board][0]
		board_select.add_child(b)

	for a in boardButtons.size():
		var btn = boardButtons[a] as Button
		#print(btn)
		btn.focus_neighbor_right = get_path_to(boardButtons[a])
		btn.focus_neighbor_left = get_path_to(boardButtons[boardButtons.size()-1])
		print(btn.focus_neighbor_right)
		btn = null
		#if a > 0 and a < boardButtons.size()-1:
			#btn.focus_neighbor_left = get_path_to(boardButtons[a-1])
			##btn.focus_neighbor_right = boardButtons[a+1]
			##btn.focus_neighbor_left = boardButtons[a-1]
		#if a == boardButtons.size():
			#btn.focus_neighbor_right = get_path_to(boardButtons[0])
			#btn.focus_neighbor_left = boardButtons[a-1]
			
func _process(delta):
	if Manager.windowMode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		fullscreen_box.button_pressed = true
	
	if not Manager.gamerulesChanged:
		%SaveGameSettings_Btn.disabled = true
	else:
		%SaveGameSettings_Btn.disabled = false
		
	if mouse_over:
		if Input.is_action_just_released("ItchGoto"):
			pass

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
	%GameSettingsBtn.grab_focus()
	menu.visible = false
func _on_board_select_back_pressed() -> void:
	board_select_menu.visible = false
	%Play.grab_focus()
	menu.visible = true

func _on_settings_pressed():
	settings.visible = true
	%CheckBox.grab_focus()
	menu.visible = false
func _on_settings_back_pressed():
	settings.visible = false
	%Play.grab_focus()
	menu.visible = true

func _on_quit_pressed():
	get_tree().quit()

func _on_logo_mouse_entered():
	mouse_over = true

func _on_logo_mouse_exited():
	mouse_over = false

func _on_game_settings_btn_pressed():
	board_select_menu.visible = false
	%BallCountSlider.grab_focus()
	game_settings.visible = true

func _on_game_settings_back_pressed():
	board_select_menu.visible = true
	%GameSettingsBtn.grab_focus()
	game_settings.visible = false
	game_settings.reset_settings()
	

func _on_save_game_settings_btn_pressed():
	if Manager.gamerulesChanged:
		confirm_box.visible = true

func _on_confirm_box_confirm(confirm:bool):
	if not confirm:
		confirm_box.visible = false
		print("Cancel")
		return
	set_changes()
	board_select_menu.visible = true
	confirm_box.visible = false
	game_settings.visible = false
	%GameSettingsBtn.grab_focus()
	print("Confirm")

func set_changes():
	Manager.ball_count = %BallCountSlider.value
	Manager.update_settings()
