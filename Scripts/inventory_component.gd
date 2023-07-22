extends Node
class_name InventoryComponent

@export var items: Array[Item] = []


func add(item: Item):
	if !items.has(item):
		items.append(item)


func contains(id: String) -> bool:
	return items.any(func(item: Item): return item.id == id)
