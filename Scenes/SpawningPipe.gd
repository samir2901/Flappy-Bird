extends Node2D

const scn_pipe = preload("res://Scenes/Pipes.tscn")
const PIPE_WIDTH = 26
const OFFSET_X = 65
const OFFSET_Y = 55
const GROUND_HEIGHT = 56

func _ready():
	var bird = get_tree().get_root().get_child(0).get_node("PlayerBird")
	if bird:
		bird.connect("state_changed",self,"on_state_changed",[],CONNECT_ONESHOT)
	pass

func on_state_changed(bird):
	if bird.get_state() == bird.STATE_FLAPPING:
		start()
	pass
	
	 
func start():
	init_pos()
	for i in range(3):
		spawn_and_move()
	pass
	
func init_pos():
	randomize()
	var init_pos = Vector2()
	var camera = get_tree().get_root().get_child(0).get_node("camera")
	init_pos.x = get_viewport_rect().size.x + PIPE_WIDTH/2
	init_pos.y = rand_range(0+OFFSET_Y,get_viewport_rect().size.y-GROUND_HEIGHT-OFFSET_Y)
	init_pos.x += camera.get_global_position().x
	set_position(init_pos)
	pass

func spawn_and_move():
	spawn_pipe()
	go_next_pos()
	

func spawn_pipe():
	var pipe = scn_pipe.instance()
	pipe.set_position(get_position())
	pipe.connect("destroyed", self, "spawn_and_move")
	get_node("container").add_child(pipe)
	
func go_next_pos():
	randomize()
	var next_pos = get_position()
	next_pos.x += PIPE_WIDTH + OFFSET_X
	next_pos.y = rand_range(0+OFFSET_Y,get_viewport_rect().size.y-GROUND_HEIGHT-OFFSET_Y)
	set_position(next_pos)
	pass