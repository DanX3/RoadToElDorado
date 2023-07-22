extends CanvasLayer
class_name MessageBox


func _input(event: InputEvent):
	if Input.is_action_pressed("action"):
		get_viewport().set_input_as_handled()
		get_tree().paused = false
		Callable(queue_free).call_deferred()


func display(text: String):
	%MessageBoxContents.text = text
	get_tree().paused = true
