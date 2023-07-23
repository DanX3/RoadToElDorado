extends Area2D


func _on_body_entered(body):
	if body.has_method("set_hook"):
		var player = get_tree().get_nodes_in_group("player")[0] as Player
		if not player.is_hanging:
			body.set_hook(false)
			body.set_hung_on_end(false)
			return
		
		body.set_hook(true)
		body.set_hung_on_end(false)


func _on_body_exited(body):
	if body.has_method("set_hook"):
		body.set_hook(false)
