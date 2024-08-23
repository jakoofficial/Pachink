extends RigidBody2D

var viewport_size = Vector2()
func _ready() -> void:
	viewport_size = get_viewport().content_scale_size

func _process(delta: float) -> void:
	if self.global_position.y > viewport_size.y+50:
		print(str(self.name) + " has been deleted")
		self.queue_free()
