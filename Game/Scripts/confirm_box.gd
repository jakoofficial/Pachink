extends Control

signal Confirm

func _on_cancel_btn_pressed():
	emit_signal("Confirm", false)

func _on_confirm_btn_pressed():
	emit_signal("Confirm", true)
