class_name FollowCamera
extends Camera2D

@export var main_character : MainCharacterController
@export var delay_bounds : Vector2
@export var target_offset : Vector2
@export var camera_speed : float = 10
@export var close_enough_distance : float = 3

#enum State {IDLE, MOVE_LEFT, MOVE_RIGHT, JUMP, FALLING}
enum CameraState {STATIC, WAITING, FOLLOWING}
var target_position : Vector2
var state : CameraState = CameraState.STATIC
var current_move_weight : float = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Move to target position
	# Target position is the main character's position plus the offset
	## Insert code
	match state:
		CameraState.STATIC:
			static_process()
			pass
		CameraState.WAITING:
			waiting_process()
			pass
		CameraState.FOLLOWING:
			following_process(delta)
			pass
	pass

func static_process():
	if position.x != target_position.x or position.y != target_position.y:
		state = CameraState.WAITING
	pass

func waiting_process():
	var x_delta = abs(position.x - target_position.x)
	var y_detla = abs(position.y - target_position.y)
	if x_delta >= delay_bounds.x or y_detla >= delay_bounds.y:
		state = CameraState.FOLLOWING
	pass

func following_process(delta):
	current_move_weight += delta * camera_speed
	var direction = (target_position - position).normalized()
	var next_position = position + direction * current_move_weight
	position = next_position
	var difference = (position - target_position).length()
	if difference <= close_enough_distance:
		current_move_weight = 0
		# TODO: Manage this based on player speed, allow for a slower lerp
		# to player position
		state = CameraState.STATIC
		position = target_position
	pass
