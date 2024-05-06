class_name SpinningBottle
extends Area2D

var fumiko : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	fumiko = AppManager.find_node_by_name("Fumiko")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print("SpinningBottle "+str(body))
	if body != fumiko:
		return
	handle_fumiko_collision()
	pass # Replace with function body.

func handle_fumiko_collision():
	print("Collided with Fumiko")
	pass
