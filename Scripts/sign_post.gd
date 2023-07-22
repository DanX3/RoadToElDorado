extends Node2D
class_name SignPost

@export_multiline var message: String

var message_box_scene = preload("res://Scenes/message_box.tscn")

func _ready():
	$InteractableComponent.interacted.connect(on_interacted)


func show_message():
	var message_box = message_box_scene.instantiate() as MessageBox
	add_child(message_box)
	
	message_box.messages.append(message)
	message_box.present()


func on_interacted():
	show_message()
