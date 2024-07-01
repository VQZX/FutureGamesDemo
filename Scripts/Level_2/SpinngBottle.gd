class_name SpinningBottle
extends Area2D

var fumiko : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Find the Fumiko character from AppManager
	## Insert code
	# fumiko = __
	pass 


func _on_body_entered(body):
	# If the entered body is not the fumiko node, return
	## Insert code

	handle_fumiko_collision()
	pass 

func handle_fumiko_collision():
	get_node(".").queue_free()
	# Play audio
	# Instantiate particle effects
	# Add information callback for collected bottle
	pass
