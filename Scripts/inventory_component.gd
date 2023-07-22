extends Node
class_name InventoryComponent

signal item_added(item: Item, inventory: InventoryComponent)

@export var items: Array[Item] = []


func size() -> int:
	return items.size()


func get_at(i: int) -> Item:
	return items[i]


func add(item: Item):
	if !items.has(item):
		items.append(item)
		item_added.emit(item, self)


func contains(id: String) -> bool:
	return items.any(func(item: Item): return item.id == id)
