extends Node2D

const scn_ground = preload("res://Scenes/Ground_Scene_Instance.tscn")
const GROUND_WIDTH = 168

func _ready():
	for i in range(2):
		spawn_ground()
		get_nextpos()
	
	
func spawn_ground():
	var new_ground = scn_ground.instance()
	new_ground.set_position(get_position())
	new_ground.connect("destroyed", self, "spawn_ground")
	new_ground.connect("destroyed", self, "get_nextpos")
	get_node("Container").add_child(new_ground)
	
	
func get_nextpos():
	set_position(get_position()+Vector2(GROUND_WIDTH,0))
	
	