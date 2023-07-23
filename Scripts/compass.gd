extends CanvasLayer

@export var path: Path2D
@export var min_dist_to_progress: float = 20
@export var max_dist_to_be_lost: float = 300
@export var origin: Node2D

var index: int = 0


func _ready():
	PlayerInventory.item_added.connect(on_item_added)


func _process(delta):
	var path_point_pos = path.to_global(path.curve.get_point_position(index))
	var dist = origin.global_position.distance_to(path_point_pos)
	
	%Arrow.rotation = (path_point_pos - origin.global_position).angle()

	if dist < min_dist_to_progress:
		index += 1
		if path.curve.point_count == index:
			print("YEAH, hai trovato Eldorado")
			index -= 1
			return
	elif dist > max_dist_to_be_lost:
		index = 0


func on_item_added(item: Item, _inventory: InventoryComponent):
	if item.id == "compass":
		visible = true
