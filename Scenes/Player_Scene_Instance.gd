extends RigidBody2D

onready var state = FlyingState.new(self)
const STATE_FLYING = 0
const STATE_FLAPPING = 1
const STATE_HIT = 2
const STATE_GROUNDED = 3
signal state_changed

func _ready():
	set_process_input(true)
	set_process(true)
	connect("body_entered",self,"on_collision")

func _process(delta):
	$AnimatedSprite.play("fly")
	pass
	

func _input(event):
	state.input(event)
	pass
	
func on_collision(colliding_body):
	if state.has_method("on_body_enter"):
		state.on_body_enter(colliding_body)
	pass
	
func set_state(new_state):
	state.exit()
	if new_state == STATE_FLYING:
		state = FlyingState.new(self)
	elif new_state == STATE_FLAPPING:
		state = FlappingState.new(self)
	elif new_state == STATE_HIT:
		state = HitState.new(self)
	elif new_state == STATE_GROUNDED:
		state = GroundedState.new(self)
		
	emit_signal("state_changed",self)
	pass
	
func get_state():
	if state is FlyingState:
		return STATE_FLYING
	elif state is FlappingState:
		return STATE_FLAPPING
	elif state is HitState:
		return STATE_HIT
	elif state is GroundedState:
		return STATE_GROUNDED
	pass

# FlyingState----------------------------------------------
class FlyingState:
	var bird
	var prev_gravity_scale
	func _init(bird):
		self.bird=bird
		bird.set_linear_velocity(Vector2(55,bird.get_linear_velocity().y))
		prev_gravity_scale = bird.get_gravity_scale()
		bird.set_gravity_scale(0)
		pass
#warning-ignore:unused_argument
	func input(event):
		pass
	func exit():
		bird.set_gravity_scale(prev_gravity_scale)
		pass
		
# FlappingState----------------------------------------------
class FlappingState:
	var bird
	func _init(bird):
		self.bird=bird
		bird.set_linear_velocity(Vector2(55,bird.get_linear_velocity().y))
		pass
#warning-ignore:unused_argument
	func input(event):
		if Input.is_action_pressed("Flap"):
			bird.set_linear_velocity(Vector2(bird.get_linear_velocity().x,-150))
		pass
	func on_body_enter(colliding_body):
		if colliding_body.is_in_group("Pipes"):
			bird.set_state(bird.STATE_HIT)
			print("Game Over")
		elif colliding_body.is_in_group("Ground"):
			bird.set_state(bird.STATE_GROUNDED)
			print("Game Over")
		pass
	func exit():
		pass
		
# HitState---------------------------------------
class HitState:
	var bird
	func _init(bird):
		self.bird=bird
		bird.set_linear_velocity(Vector2(0,0))
		var colliding_body = bird.get_colliding_bodies()[0]
		bird.add_collision_exception_with(colliding_body)
		pass
	func input(event):
		pass
	func exit():
		pass
		
		
# FlyingState----------------------------------------------
class GroundedState:
	var bird
	func _init(bird):
		self.bird=bird
		bird.set_linear_velocity(Vector2(0,0))
		var colliding_body = bird.get_colliding_bodies()[0]
		bird.add_collision_exception_with(colliding_body)
		pass
	func input(event):
		pass
	func exit():
		pass