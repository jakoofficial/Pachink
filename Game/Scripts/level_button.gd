extends Button

signal goto_level(level)

var level = 0

func _on_pressed() -> void:
	emit_signal("goto_level", level)
