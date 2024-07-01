class_name MainCharacterController
extends CharacterBody2D
###############################################################################
@export var max_jumps = 2
@export var speed = 300.0
@export var animation_controller : MainCharacterSpriteAnimator
@export var jump_velocity = -400.0
@export var second_jump_velocity = -100.0
@export var max_jump_velocity = -600
###############################################################################
const MOVE_LEFT_INPUT = "move_left"
const MOVE_RIGHT_INPUT = "move_right"
const JUMP_INPUT = "jump"
const INTERACT_INPUT = "interact"
###############################################################################


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

func GetPosition() -> Vector2:
	return position;

# Initialisation
func _init():
	var _myself = get_node(".")
	
func _ready():
	animation_controller = get_node("Fumiko_Animation") as MainCharacterSpriteAnimator
	previous_position = position
	
# Input controls
func _input(event):
	# Calculate the amount changed along the horizontal
	var horizontal_change = speed * get_process_delta_time()
	
	# Is it a left input, or a right input
	if event.is_action_pressed(MOVE_LEFT_INPUT):
		# Use Add input state to track left input
		## Insert code
		# Remove right Input
		## Insert code
		# Set  Horizontal direction to negative 1
		## Insert code
		pass
	elif event.is_action_pressed(MOVE_RIGHT_INPUT):
		# Use add input state to track left input
		## Insert code
		# Remove left input state
		## Insert code
		# Set Horizontal direction to 1
		## Insert code
		pass
		
	if current_state != State.JUMP or current_state != State.FALLING:
		if event.is_action_released(MOVE_LEFT_INPUT):
			# Set Idle state
			## Insert code
			# Set horizontal direction to 0
			## Insert code
			pass
		elif event.is_action_released(MOVE_RIGHT_INPUT):
			# Set Idle state
			## Insert code
			# Set horizontal direction to 0
			## Insert code
			pass
			
	if event.is_action_pressed(JUMP_INPUT):
		if current_jumps < max_jumps:
			# Use add input state to track jumping
			## Insert code
			# Set vertical directiont to negative 1
			## Insert code
			pass
			if current_jumps > 0:
				handle_jump()
	
func handle_jump():
	if current_jumps < max_jumps:
		match current_jumps:
			0: 
				# Add jump velocity to vertical vertical velocity
				## Insert code
				pass
			1: 
				#print("current jumps 1")
				# On Double Jump, ensure the velocity to or or more
				## Insert code
				# Add the jump velocity
				## Insert code
				pass
		## Play the Jump Animation, with the correct sprite direction
		animation_controller.play_animation(animation_controller.JUMP, sprite_direction)
		## Insert code
		# Add 1 to jump to keep track of the amount of jumps made
		## Insert code
		# Ensure we limit the jump velocity
		limit_jump_velocity()

func handle_idle():
	# If the velocity is moving in any direction
	# Return
	## Insert code
	
	## Play the Idle Animation, with the correct sprite direction
	## Insert code

	# Otherwse
	# Check if we are moving left, or moving right
	# And then move left or right respectively
	## Insert code
	pass
	
func handle_falling():
	# Play FALL_DOWN animation, with correct sprite direction
	## Insert code

	# We prioritise moving left
	# We check if we are moving left or right
	# And then handle that process
	if State.MOVE_LEFT in input_tracker:
		handle_move_left()
	elif State.MOVE_RIGHT in input_tracker:
		handle_move_right()
		
		
	if is_on_floor(): 
		set_idle_state()
		current_jumps = 0
		#print(" falling Change Jump to zero")

func handle_move_left():
	# Calculate the horizontal movement amount based on speed and delta time
	## Insert code
	# Calculate the change left for that process
	## Insert code
	# Use Godot move_and_collide() to see if we have collided with anything
	## Insert code
	# Change sprite direction to be negative (left)
	## Insert code
	# Play Animaton to run, with correct sprite direction
	## Insert code
	pass
	
func handle_move_right():
	# Calculate the horizontal movement amount based on speed and delta time
	## Insert code
	# Calculate the change right for that process
	## Insert code
	# Use Godot move_and_collide() to see if we have collided with anything
	## Insert code
	# Change sprite direction to be positive (right)
	## Insert code
	# Play Animaton to run, with correct sprite direction
	## Insert code
	pass
	
func _process(delta):
	# Calculate how much the position has changed
	## Insert code
	# Keep track of a simplified approximation of the velocity
	# Divide the change in position, by the time that has passed
	## Insert code
	# Store the current position in the previous position value
	## Insert code
	
	# Force sprite direction
	# Prioritise facing right
	# if input_tracker contains State.MOVE_RIGHT and the horzintal velicity is positive
	# then set the animation controlle to play run, in the positive direction
	## Insert code
	# Otherwise
	# if the character should be facing left, then play animation controller
	# in the left direction
	## Insert code
	pass
	

func _physics_process(delta):
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
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	elif is_on_floor():
		current_jumps = 0
		#print("physics Change Jump to zero")

	# Handle Falling
	if velocity.y < 0:
		current_state = State.FALLING
		direction.y = 1
		
	move_and_slide()
	
	
#########################################################################
#### HELPER FUNCTIONS ###################################################

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
