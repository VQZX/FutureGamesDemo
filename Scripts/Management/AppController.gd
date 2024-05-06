class_name AppController
extends Node2D

@export var number_of_levels: int = 2
@export var level_1_path: String = "res://Scenes/level_x_1.tscn"
@export var level_2_path: String = "res://Scenes/level_2.tscn"

	
func _input(event):
	# Debug for loading scenes on the fly
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_1:
			print("1 was pressed")
			get_tree().change_scene_to_file(level_1_path)
		if event.keycode == KEY_2:
			print("2 was pressed")
			get_tree().change_scene_to_file(level_2_path)
	
	

