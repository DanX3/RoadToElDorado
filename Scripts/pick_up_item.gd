@tool

extends Node2D
class_name PickUpItem

@export var item: Item : set = _set_item
@export var sprite_scale: Vector2 = Vector2.ONE : set = _set_sprite_scale

func _ready():
	$InteractableComponent.interacted.connect(on_interacted)


func _set_item(value: Item):
	item = value
	$Sprite2D.texture = item.texture


func _set_sprite_scale(value: Vector2):
	sprite_scale = value
	$Sprite2D.scale = sprite_scale


func pick_up():
	assert(item)

	PlayerInventory.add(item)
	queue_free.call_deferred()


func on_interacted():
	pick_up()
