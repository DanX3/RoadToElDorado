extends RigidBody2D
class_name Npc

var message_box_scene = preload("res://Scenes/message_box.tscn")


func _ready():
	$InteractableComponent.interacted.connect(on_interacted)


func on_interacted():
	var message_box = message_box_scene.instantiate() as MessageBox
	add_child(message_box)
	
	message_box.display("Ciao bello")
