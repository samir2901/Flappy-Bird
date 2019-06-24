extends Container

func _ready():
	var bird = get_tree().get_root().get_child(0).get_node("PlayerBird")
	if bird:
		bird.connect("state_changed",self,"_on_game_over")
	pass

func _on_game_over(bird):
	if bird.get_state() == bird.STATE_GROUNDED:
		show()
	if bird.get_state() == bird.STATE_HIT:
		show()
	pass