class_name ExitDoorController
extends Area2D

@export var delay_scene_change = 5
@export var level_to_change_to: int = 1
@export var animation : AnimatedSprite2D

var fumiko:Node2D

var timer_activated = false;
var current_time = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Exit Door controller ready "+name)
	fumiko = AppManager.find_node_by_name("Fumiko")
	print("Ready: "+str(fumiko))
	pass # Replace with function body.
	
func _process(delta):
	##############################
	# If timer is not activated, we dont do anything -- return
	# Otherwise
	# Add delta to current time
	# if current time is more than the delay (delay_scene_change)
	# -- Change level
	pass

func _on_body_entered(body):
	########################
	# if the entered body is not Fumiko, return
	# Otherwise, activate timer (timer_activated)
	# Play opening animation
	pass
