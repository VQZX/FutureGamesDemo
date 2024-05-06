class_name AppController
extends Node2D

@export var number_of_levels: int = 2
@export var level_1_path: String = "res://Scenes/level_x_1.tscn"
@export var level_2_path: String = "res://Scenes/level_2.tscn"

var current_scene = level_1_path
	
func _input(event):
	# Debug for loading scenes on the fly
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_1:
			print("1 was pressed")
			get_tree().change_scene_to_file(level_1_path)
		if event.keycode == KEY_2:
			print("2 was pressed")
			get_tree().change_scene_to_file(level_2_path)
	
	
func change_to_level(level_order: int):
	var level_to_change_to: String = ""
	match level_order:
		1: 
			level_to_change_to = level_1_path
		2:
			level_to_change_to = level_2_path
	if level_to_change_to == "":
		print("Invalid Level Order")
		return
	get_tree().change_scene_to_file(level_to_change_to)
	current_scene = level_to_change_to
	
func change_to_level_one():
	change_to_level(1)

func change_to_level_two():
	change_to_level(2)
	
func find_node_by_name(node_name):
	var current_scene = get_tree().current_scene.name
	var path = current_scene +"/"+ node_name
	return get_tree().get_root().get_node(path)
	
	
	

