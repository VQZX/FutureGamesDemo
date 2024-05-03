class_name MainCharacterSpriteAnimator
extends AnimatedSprite2D

# Animation Names
const IDLE = "idle"
const WALK = "walk"
const RUN = "run"
const JUMP = "jump_up"
const FALL_DOWN = "fall_down"

var current_animation = ""

# Calling Actions
func play_animation(animation_name, direction = 0):
	if (animation_name == current_animation):
		return
	stop()
	play(animation_name)
	if direction == 1 or direction == 0:
		flip_h = false
	else:
		flip_h = true
	current_animation = animation_name
	var string_direction = str(direction)
	#print("AnimatedSpriteWrapper: "+current_animation+" "+string_direction)
	


