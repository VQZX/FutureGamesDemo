class_name ExitDoorController
extends Area2D

@export var delay_scene_change = 5
@export var scene_to_change_to = "res://Scenes/level_2.tscn"

var timer_activated = false;
var current_time = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Exit Door controller ready "+name)
	pass # Replace with function body.
	
func _process(delta):
	if ( not timer_activated):
		return
	current_time = current_time + delta
	if current_time >= delay_scene_change:
		get_tree().change_scene(scene_to_change_to)

func _on_body_entered(body):
	print("Entered "+str(body))
	timer_activated = true;
