extends RigidBody2D
class_name Npc


func _ready():
	$InteractableComponent.interacted.connect(on_interacted)


func on_interacted():
	$QuestGiverComponent.inventory = get_tree().get_first_node_in_group("player").get_inventory()
	$QuestGiverComponent.interact()
