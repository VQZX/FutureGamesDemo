class_name ExitDoorController
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Exit Door controller ready "+name)
	pass # Replace with function body.
	
func _on_body_entered(body):
	print("Entered "+str(body))
