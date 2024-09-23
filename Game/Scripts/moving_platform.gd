extends StaticBody2D

@export var move_speed:float = 10.0
@onready var sprite = $Sprite2D as Sprite2D

@export var offset_x1: int = 0
@export var offset_x2: int = 0


func _physics_process(delta):
	var posX = self.global_position.x
	#Bounce Indicator at the edge of the viewport
	if posX > get_viewport().content_scale_size.x - offset_x2 - (sprite.texture.get_width() / 2) or posX < offset_x1 + (sprite.texture.get_width()/2):
		move_speed = -move_speed
	# Move Indicator
	self.global_position.x += move_speed * 100 * delta
