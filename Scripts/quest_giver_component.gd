extends Node

@export var quest_item: Item
@export var inventory: Node
@export var reward: Item

@export_multiline var introduction_messages: Array[String]
@export_multiline var quest_item_not_present_messages: Array[String]
@export_multiline var quest_completed_messages: Array[String]

var message_box_scene = preload("res://Scenes/message_box.tscn")


func interact() -> bool:
	var message_box = message_box_scene.instantiate() as MessageBox
	add_child(message_box)
	
	message_box.messages.append_array(introduction_messages)
	message_box.messages.append_array(quest_item_not_present_messages)
	# message_box.messages.append_array(quest_completed_messages)
	
	message_box.present()
	
	return false
