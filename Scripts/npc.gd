extends RigidBody2D
class_name Npc



func _ready():
	$InteractableComponent.interacted.connect(on_interacted)


func on_interacted():
	$QuestGiverComponent.inventory = PlayerInventory
	$QuestGiverComponent.interact()
