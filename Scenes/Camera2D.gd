extends Camera2D

onready var bird_node = get_node("../PlayerBird")
func _ready():
	set_physics_process(true)

func _physics_process(delta):
	var bird_pos = bird_node.get_position()
	set_position(Vector2(bird_pos.x,get_position().y))
	

	