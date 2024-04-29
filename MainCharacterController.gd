class_name MainCharacterController
extends CharacterBody2D
###############################################################################
@export var max_jumps = 2
@export var animation_controller : AnimatedSpriteWrapper
@export var jump_velocity = -400.0
@export var second_jump_velocity = -100.0
@export var max_jump_velocity = -600
###############################################################################
const MOVE_LEFT_INPUT = "move_left"
const MOVE_RIGHT_INPUT = "move_right"
const JUMP_INPUT = "jump"
const INTERACT_INPUT = "interact"

const SPEED = 300.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum State {IDLE, MOVE_LEFT, MOVE_RIGHT, JUMP, FALLING}
enum Horizontal_sprite_direction {LEFT = -1, RIGHT = 1}

var current_jumps = 0
var current_state: State = State.IDLE
var previous_position: Vector2
var position_delta: Vector2
var simple_velocity: Vector2
var sprite_direction: Horizontal_sprite_direction = 1

var direction: Vector2

var input_tracker = []

# Initialisation
func _init():
	var _myself = get_node(".")
	
func _ready():
	animation_controller = get_node("Fumiko_Animation") as AnimatedSpriteWrapper
	previous_position = position
	
# Input controls
func _input(event):
	var horizontal_change = SPEED * get_process_delta_time()
	if event.is_action(MOVE_LEFT_INPUT):
		add_input_state(State.MOVE_LEFT)
		remove_input_state(State.MOVE_RIGHT)
		direction.x = -1
	elif event.is_action(MOVE_RIGHT_INPUT):
		add_input_state(State.MOVE_RIGHT)
		remove_input_state(State.MOVE_LEFT)
		direction.x = 1
		
	if current_state != State.JUMP or current_state != State.FALLING:
		if event.is_action_released(MOVE_LEFT_INPUT):
			set_idle_state()
			direction.x = 0
		elif event.is_action_released(MOVE_RIGHT_INPUT):
			set_idle_state()
			direction.x = 0
			
	if event.is_action_pressed(JUMP_INPUT):
		if current_jumps < max_jumps:
			add_input_state(State.JUMP)
			direction.y = -1
	
func handle_jump():
	if current_jumps < max_jumps:
		match current_jumps:
			0: 
				velocity.y = velocity.y + jump_velocity
				print("Velocity: "+str(velocity))
			1: 
				velocity.y = velocity.y + second_jump_velocity
				print("Velocity: "+str(velocity))
		animation_controller.play_animation(animation_controller.JUMP, sprite_direction)
		current_jumps = current_jumps + 1
		limit_jump_velocity()

func handle_idle():
	if velocity.length() > 0:
		return
	animation_controller.play_animation(animation_controller.IDLE, sprite_direction)
	if State.MOVE_LEFT in input_tracker:
		handle_move_left()
	elif State.MOVE_RIGHT in input_tracker:
		handle_move_right()
	pass
	
func handle_falling():
	animation_controller.play_animation(animation_controller.FALL_DOWN, sprite_direction)
	if State.MOVE_LEFT in input_tracker:
		handle_move_left()
	elif State.MOVE_RIGHT in input_tracker:
		handle_move_right()
	if is_on_floor(): 
		set_idle_state()
		current_jumps = 0

func handle_move_left():
	var horizontal_change = SPEED * get_process_delta_time()
	var total_change = Vector2.LEFT * horizontal_change
	var output = move_and_collide(total_change)
	sprite_direction = -1
	animation_controller.play_animation(animation_controller.RUN, int(sprite_direction))
	pass
	
func handle_move_right():
	var horizontal_change = SPEED * get_process_delta_time()
	var total_change = Vector2.RIGHT * horizontal_change
	var output = move_and_collide(total_change)
	sprite_direction = 1
	animation_controller.play_animation(animation_controller.RUN, int(sprite_direction))
	pass
	

func _process(delta):
	position_delta = position - previous_position
	simple_velocity = position_delta / delta
	previous_position = position
	
	match current_state:
		State.IDLE:
			handle_idle()
		State.MOVE_LEFT:
			handle_move_left()
		State.MOVE_RIGHT:
			handle_move_right()
		State.JUMP:
			handle_jump()
		State.FALLING:
			handle_falling()

func _physics_process(delta):
	# Add the gravity.
	
	if not is_on_floor():
		velocity.y += gravity * delta
	elif is_on_floor():
		current_jumps = 0
		print("Velocity: "+str(velocity))

	# Handle Falling
	if velocity.y < 0:
		current_state = State.FALLING
		direction.y = 1

	move_and_slide()
	#print("Falling Speed: "+str(velocity.y))
	
func add_input_state(state: State):
	remove_input_state(state) 
	input_tracker.append(state)
	current_state = state

func remove_input_state(state: State):
	if state in input_tracker:
		var index = input_tracker.find(state)
		input_tracker.remove_at(index) 

func set_idle_state():
	input_tracker.clear()
	add_input_state(State.IDLE)

func limit_jump_velocity():
	if velocity.y < max_jump_velocity:
		velocity.y = max_jump_velocity;
