extends Node2D
class_name PickUpItem

@export var item: Item : set = _set_item


func _ready():
	$InteractableComponent.interacted.connect(on_interacted)


func _set_item(value: Item):
	item = value
	$Sprite2D.texture = item.texture


func pick_up():
	assert(item)

	PlayerInventory.add(item)
	queue_free.call_deferred()


func on_interacted():
	pick_up()
