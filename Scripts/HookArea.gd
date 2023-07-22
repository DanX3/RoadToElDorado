extends Area2D

func _on_body_entered(body):
	if body.has_method("set_hook"):
		body.set_hook(true)
		body.set_hung_on_end(true)


func _on_body_exited(body):
	if body.has_method("set_hook"):
		body.set_hook(false)
