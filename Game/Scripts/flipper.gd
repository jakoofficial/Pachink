extends StaticBody2D

@export_group("Tweener")
@export var flip: bool = false
@export var start_rotation: float = 25
@export var interval:float = 1
@export var degrees: float = 25

var tween
func _ready():
	rotation = start_rotation
	if flip:
		scale.x = -scale.x
	tween_setup()

func tween_setup(call: Callable = new_time, interval:float = interval, degrees:float = degrees):
	tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_ELASTIC).set_loops() as Tween
	tween.tween_property(self, "rotation", deg_to_rad(-degrees), interval).as_relative()
	tween.tween_callback(call)

func new_time():
	tween.kill()
	degrees = -degrees
	tween_setup(new_time, interval, degrees)
