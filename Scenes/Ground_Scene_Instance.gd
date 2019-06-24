extends StaticBody2D

onready var bottom_right = get_node("BottomRight")
onready var camera = get_tree().get_root().get_child(0).get_node("camera")

signal destroyed

func _ready():
	set_process(true)
	add_to_group("Ground")
	pass 
	
func _process(delta):
	if camera == null:
		return
	if bottom_right.get_global_position().x <= camera.get_global_position().x - 36:
		queue_free()
		emit_signal("destroyed")
		pass