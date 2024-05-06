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
	if ( not timer_activated):
		return
	current_time = current_time + delta
	if current_time >= delay_scene_change:
		AppManager.change_to_level(level_to_change_to)

func _on_body_entered(body):
	print("Entered "+str(body))
	if body != fumiko:
		return
	timer_activated = true;
	animation.play("opening")
