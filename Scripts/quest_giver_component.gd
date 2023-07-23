extends Node

@export var inventory: InventoryComponent
@export var quest_item: Item
@export var consume_quest_item: bool = false
@export var reward: Item

@export_multiline var introduction_messages: Array[String]
@export_multiline var quest_item_not_present_messages: Array[String]
@export_multiline var quest_completed_messages: Array[String]

var message_box_scene = preload("res://Scenes/message_box.tscn")


func interact() -> bool:
	var quest_completed = (quest_item == null) or (inventory.contains(quest_item.id) if inventory else false)

	var message_box = message_box_scene.instantiate() as MessageBox
	add_child(message_box)

	message_box.messages.append_array(introduction_messages)
	if quest_completed:
		message_box.messages.append_array(quest_completed_messages)
	else:
		message_box.messages.append_array(quest_item_not_present_messages)

	message_box.present()
	await message_box.finished

	if reward and quest_completed:
		inventory.add(reward)
		
	if quest_item && consume_quest_item:
		inventory.remove(quest_item.id)

	return quest_completed
