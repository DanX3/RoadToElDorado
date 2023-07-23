extends CanvasLayer
class_name InventoryUi

const MAX_SLOTS: int = 6

@onready var inventory_bar: HBoxContainer = %InventoryBar

var inventory_slots: Array[InventorySlot] = []

var inventory_slot_scene = preload("res://Scenes/inventory_slot.tscn")

func _ready():
	PlayerInventory.item_added.connect(on_item_added)
	PlayerInventory.item_removed.connect(on_item_removed)

	for i in MAX_SLOTS:
		var slot = inventory_slot_scene.instantiate() as InventorySlot
		inventory_bar.add_child(slot)
		inventory_slots.append(slot)

	update_inventory(PlayerInventory)


func update_inventory(inventory: InventoryComponent):
	var i = 0
	while i < min(inventory.size(), MAX_SLOTS):
		inventory_slots[i].texture = inventory.get_at(i).texture
		i += 1

	while i < MAX_SLOTS:
		inventory_slots[i].texture = null
		i += 1


func on_item_added(_item: Item, inventory: InventoryComponent):
	update_inventory(inventory)


func on_item_removed(_item: Item, inventory: InventoryComponent):
	update_inventory(inventory)
