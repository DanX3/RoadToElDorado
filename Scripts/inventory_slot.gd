extends PanelContainer
class_name InventorySlot

@export var item: Item : set = _set_item


func _set_item(other: Item):
	item = other
	tooltip_text = item.name if item else ""
	%TextureRect.texture = item.texture if item else null
