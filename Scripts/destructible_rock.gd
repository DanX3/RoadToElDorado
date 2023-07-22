extends RigidBody2D
class_name DestructibleRock

var bomb_scene = preload("res://Scenes/bomb.tscn")
var message_box_scene = preload("res://Scenes/message_box.tscn")


func _ready():
	$InteractableComponent.interacted.connect(on_interacted)


func on_interacted():
	if PlayerInventory.contains("bombs"):
		var bomb = bomb_scene.instantiate() as Bomb
		get_tree().root.add_child(bomb)

		bomb.global_position = get_tree().get_first_node_in_group("player").global_position
	else:
		var message_box = message_box_scene.instantiate() as MessageBox
		get_tree().root.add_child(message_box)

		message_box.messages.append("I need bombs to blow up this boulder...")
		message_box.present()
