extends Node2D

@export var path: Path2D
@export var min_dist_to_progress: float = 20
@export var max_dist_to_be_lost: float = 300

var index: int = 0


func _process(delta):
	position = get_global_mouse_position()
	
	var path_point_pos = path.to_global(path.curve.get_point_position(index))
	var dist = position.distance_to(path_point_pos)
	look_at(path_point_pos)
	

	if dist < min_dist_to_progress:
		index += 1
		if path.curve.point_count == index:
			print("YEAH, hai trovato Eldorado")
			return
	elif dist > max_dist_to_be_lost:
		index = 0
	
